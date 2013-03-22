Coursewareable::Engine.routes.draw do
  scope :module => :api do
    namespace :v1 do
      resources :users, :only => [] do
        get :me, :on => :collection
      end
      resources :classrooms, :only => [:index, :show]
      get 'timeline' => 'classrooms#timeline', :as => 'timeline'
      get 'collaborators' => 'classrooms#collaborators', :as => 'collaborators'
    end
  end

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
