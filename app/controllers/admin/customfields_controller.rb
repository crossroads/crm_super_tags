# Fat Free CRM
# Copyright (C) 2008-2009 by Michael Dvorkin
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#------------------------------------------------------------------------------

class Admin::CustomfieldsController < Admin::ApplicationController
  before_filter :require_user
  before_filter :set_current_tab, :only => [ :index, :show ]
  before_filter :auto_complete, :only => :auto_complete

  def sort
    params[:customfields].each_with_index do |id, index|
      Customfield.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end


  # GET /customfields/1
  # GET /customfields/1.xml                                                    HTML
  #----------------------------------------------------------------------------
  def show
    @customfield = Customfield.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @customfield }
    end

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:html, :xml)
  end

  # GET /customfields/new
  # GET /customfields/new.xml                                                  AJAX
  #----------------------------------------------------------------------------
  def new
    @customfield = Customfield.new(:user => @current_user, :tag_id => params[:tag_id])
    @disabled = false

    respond_to do |format|
      format.js   # new.js.rjs
      format.xml  { render :xml => @customfield }
    end

  rescue ActiveRecord::RecordNotFound # Kicks in if related asset was not found.
    respond_to_not_found(:html, :xml)
  end

  # GET /customfields/1/edit                                                   AJAX
  #----------------------------------------------------------------------------
  def edit
    @customfield = Customfield.find(params[:id])
    @disabled = :disabled

    if params[:previous].to_s =~ /(\d+)\z/
      @previous = Customfield.find($1)
    end

  rescue ActiveRecord::RecordNotFound
    @previous ||= $1.to_i
    respond_to_not_found(:js) unless @customfield
  end

  # POST /customfields
  # POST /customfields.xml                                                     AJAX
  #----------------------------------------------------------------------------
  def create
    @customfield = Customfield.new(params[:customfield])
    @disabled = false

    respond_to do |format|
      if @customfield.save
        @customfields = if params[:customfield][:tag_id]
          ActsAsTaggableOn::Tag.find(params[:customfield][:tag_id]).customfields
        elsif called_from_index_page?
          get_customfields
        end
        format.js   # create.js.rjs
        format.xml  { render :xml => @customfield, :status => :created, :location => @customfield }
      else
        format.js   # create.js.rjs
        format.xml  { render :xml => @customfield.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /customfields/1
  # PUT /customfields/1.xml                                                    AJAX
  #----------------------------------------------------------------------------
  def update
    @customfield = Customfield.find(params[:id])

    respond_to do |format|
      if @customfield.update_attributes(params[:customfield])
        format.js
        format.xml  { head :ok }
      else
        format.js
        format.xml  { render :xml => @customfield.errors, :status => :unprocessable_entity }
      end
    end

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:js, :xml)
  end

  # DELETE /customfields/1
  # DELETE /customfields/1.xml                                        HTML and AJAX
  #----------------------------------------------------------------------------
  def destroy
    @customfield = Customfield.find(params[:id])
    @customfield.destroy if @customfield

    respond_to do |format|
      format.html { respond_to_destroy(:html) }
      format.js   { respond_to_destroy(:ajax) }
      format.xml  { head :ok }
    end

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:html, :js, :xml)
  end

  # GET /customfields/search/query                                             AJAX
  #----------------------------------------------------------------------------
  def search
    @customfields = get_customfields(:query => params[:query], :page => 1)

    respond_to do |format|
      format.js   { render :action => :index }
      format.xml  { render :xml => @customfields.to_xml }
    end
  end

  # POST /customfields/auto_complete/query                                     AJAX
  #----------------------------------------------------------------------------
  # Handled by before_filter :auto_complete, :only => :auto_complete

  # GET /customfields/options                                                  AJAX
  #----------------------------------------------------------------------------
  def options
    unless params[:cancel] == "true"
      @per_page = @current_user.pref[:customfields_per_page] || Customfield.per_page
      @outline  = @current_user.pref[:customfields_outline]  || Customfield.outline
      @sort_by  = @current_user.pref[:customfields_sort_by]  || Customfield.sort_by
      @sort_by  = Customfield::SORT_BY.invert[@sort_by]
    end
  end

  # POST /customfields/redraw                                                  AJAX
  #----------------------------------------------------------------------------
  def redraw
    @current_user.pref[:customfields_per_page] = params[:per_page] if params[:per_page]
    @current_user.pref[:customfields_outline]  = params[:outline]  if params[:outline]
    @current_user.pref[:customfields_sort_by]  = Customfield::SORT_BY[params[:sort_by]] if params[:sort_by]
    @customfields = get_customfields(:page => 1) # Start one the first page.

    render :action => :index
  end

  private
  #----------------------------------------------------------------------------
  def get_customfields(options = { :page => nil, :query => nil })
    self.current_page = options[:page] if options[:page]
    self.current_query = options[:query] if options[:query]

    records = {
      :user => @current_user,
      :order => @current_user.pref[:customfields_sort_by] || Customfield.sort_by
    }
    pages = {
      :page => current_page,
      :per_page => @current_user.pref[:customfields_per_page]
    }

    # Call :get_customfields hook and return its output if any.
    customfields = hook(:get_customfields, self, :records => records, :pages => pages)
    return customfields.last unless customfields.empty?

    # Default processing if no :get_customfields hooks are present.
    if current_query.blank?
      Customfield.find(:all)
    else
      Customfield.search(current_query)
    end.paginate(pages)
  end

  #----------------------------------------------------------------------------
  def respond_to_destroy(method)
    if method == :ajax
      if called_from_index_page?
        @customfields = get_customfields
        if @customfields.blank?
          @customfields = get_customfields(:page => current_page - 1) if current_page > 1
          render :action => :index and return
        end
      else
        self.current_page = 1
      end
      # At this point render destroy.js.rjs
    else
      self.current_page = 1
      flash[:notice] = "#{@customfield.field_name} has beed deleted."
      redirect_to(customfields_path)
    end
  end
end

