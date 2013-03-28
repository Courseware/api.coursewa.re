Coursewareable::Engine.routes.draw do
  scope :module => :api do
    namespace :v1 do
      resources :users, :only => [] do
        get :me, :on => :collection
      end

      resources :classrooms, :only => [:index, :show] do
        get :collaborators
        get :timeline
      end

      resource :syllabus, :only => [:show]

    end
  end

  # External authentication callback
  match 'oauth/callback' => 'oauths#callback'
  match 'oauth/authenticate' => 'oauths#authenticate'
  match 'oauth/:provider' => 'oauths#oauth', :as => :auth_at_provider
end

CoursewareAPI::Application.routes.draw do
  # Route overwrites come below:
  use_doorkeeper do
    # can be :authorizations, :tokens, :applications, :authorized_applications
    skip_controllers :applications, :authorized_applications
  end


  # Mount the Coursewareable Engine
  mount Coursewareable::Engine => '/'
end
