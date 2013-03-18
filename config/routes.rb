Coursewareable::Engine.routes.draw do
  scope :module => :api do
    namespace :v1 do
      resource :homes, :only => :show
    end
  end

  root :to => 'api/v1/homes#show'
end

CoursewareAPI::Application.routes.draw do
  # Route overwrites come below:

  # Mount the Coursewareable Engine
  mount Coursewareable::Engine => '/'
end
