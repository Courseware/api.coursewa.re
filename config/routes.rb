Coursewareable::Engine.routes.draw do
  use_doorkeeper do
    # can be :authorizations, :tokens, :applications, :authorized_applications
    skip_controllers :applications, :authorized_applications
  end

  scope :module => :api do
    namespace :v1 do
      resources :users, :only => [] do
        get :me, :on => :collection
      end
    end
  end

end

CoursewareAPI::Application.routes.draw do
  # Route overwrites come below:

  # Mount the Coursewareable Engine
  mount Coursewareable::Engine => '/'
end
