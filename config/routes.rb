FatFreeCrm::Application.routes.draw do

  namespace :admin do
    resources :super_tags do
      collection do
        post :auto_complete
        get :options
        post :redraw
        get :search
      end
    end

    resources :customfields, :except => :index do
      collection do
        post :auto_complete
        get :options
        post :redraw
        get :search
      end
    end
  end
end
