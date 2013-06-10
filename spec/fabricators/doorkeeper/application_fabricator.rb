Fabricator(:doorkeeper_app, :class_name => ::Doorkeeper::Application) do
  owner(:fabricator => 'coursewareable/user')
  name          { sequence(:app_id){ Faker::Company.name + ' App' } }
  redirect_uri  { 'http://%s/callback' % Faker::Internet.domain_name }
end
