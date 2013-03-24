require 'spec_helper'

# Stolen from sorcery spec files
def stub_all_oauth2_requests!
  auth_code       = OAuth2::Strategy::AuthCode.any_instance
  access_token    = mock(OAuth2::AccessToken)
  access_token.stub(:token_param=)
  response        = mock(OAuth2::Response)
  response.stub(:body).and_return({
    'id'         => rand(1000),
    'name'       => Faker::Name.name,
    'first_name' => Faker::Name.first_name,
    'last_name'  => Faker::Name.last_name,
    'link'       => Faker::Internet.http_url,
    'bio'        => Faker::Lorem.sentence,
    'email'      => Faker::Internet.email
  }.to_json)
  access_token.stub(:get).and_return(response)
  auth_code.stub(:get_token).and_return(access_token)
end

describe Coursewareable::OauthsController do
  before(:each) do
    stub_all_oauth2_requests!
  end

  describe '#oatuh' do
    let(:provider) { :facebook }
    before { get :oauth, :provider => provider }

    its(:status) { should eq(302)}

    context 'for Facebook authentication' do
      subject{ response.header.first }

      # aka Location
      its('last') { should match('graph.facebook.com') }
    end
  end

  describe '#callback' do
    let(:provider) { :facebook }
    before(:each) do
      Coursewareable::Authentication.delete_all
      get :callback, :provider => provider
    end

    context 'for Facebook authentication' do
      it 'creates a new user' do
        response.status.should eq(200)
        Coursewareable::Authentication.all.should_not be_empty

        body = JSON.parse(response.body)
        body['error'].should be_false
        body['provider'].should eq(provider.to_s)
        body['created'].should be_true
      end

      it 'logs in the user' do
        # On second request
        get :callback, :provider => provider

        response.status.should eq(200)
        Coursewareable::Authentication.all.should_not be_empty

        body = JSON.parse(response.body)
        body['error'].should be_false
        body['provider'].should eq(provider.to_s)
        body['created'].should be_false
      end

      context 'when something goes wrong' do
        before(:all) do
          setup_controller_request_and_response
          @controller.stub(:create_from).and_return(false)
        end

        it 'fails silently with proper response' do
          response.status.should eq(400)
          Coursewareable::Authentication.all.should be_empty

          body = JSON.parse(response.body)
          body['error'].should be_true
          body['provider'].should eq(provider.to_s)
          body['created'].should be_false
        end
      end
    end
  end
end
