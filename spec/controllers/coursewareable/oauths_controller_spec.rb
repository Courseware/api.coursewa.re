require 'spec_helper'

# Stolen from sorcery spec files
def stub_all_oauth2_requests!
  resp_hash = {
    'id'         => rand(1000),
    'name'       => Faker::Name.name,
    'first_name' => Faker::Name.first_name,
    'last_name'  => Faker::Name.last_name,
    'link'       => Faker::Internet.http_url,
    'bio'        => Faker::Lorem.sentence,
    'email'      => Faker::Internet.email
  }.to_json

  response = double(OAuth2::Response, :body => resp_hash)

  access_token = double(
    OAuth2::AccessToken, :token_param= => true, :get => response)

  OAuth2::Strategy::AuthCode.any_instance.stub(
    :get_token).and_return(access_token)
end

describe Coursewareable::OauthsController do

  routes { Coursewareable::Engine.routes }

  describe 'external call of' do
    before(:each) do
      stub_all_oauth2_requests!
    end

    describe '#oauth' do
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
  end # external

  describe 'credentials call for' do
    describe '#authenticate' do
      let(:user){ Fabricate(:confirmed_user) }
      let(:oauth_app){ Fabricate(:doorkeeper_app) }
      let(:existing_token) { '' }

      before do
        @controller.stub(:form_authenticity_token => true)
        post(:authenticate, :email => user.email, :password => 'secret',
             :client_id => oauth_app.uid, :access_token => existing_token)
      end

      context 'with wrong application key' do
        before(:all) { oauth_app.uid = rand(100) }

        it 'responds with error' do
          response.status.should eq(400)

          body = JSON.parse(response.body)
          body['error'].should be_true
        end
      end

      context 'with wrong user credentials' do
        before(:all) do
          user.stub(:email) { Faker::Internet.email }
        end

        it 'responds with error' do
          response.status.should eq(400)

          body = JSON.parse(response.body)
          body['error'].should be_true
        end
      end

      context 'with existing access token' do
        before(:all) do
          user.stub(:email) { '' }
        end

        context 'which is ok' do
          let(:existing_token) do
            oauth_app.authorized_tokens.create(
              :resource_owner_id => user.id).token
          end

          it 'responds with validated access token' do
            response.status.should eq(200)

            body = JSON.parse(response.body)
            body['error'].should be_false
            body['access_token'].should eq(existing_token)
          end
        end

        context 'which is wrong' do
          let(:existing_token) { rand(100..200) }

          it 'responds with an error' do
            response.status.should eq(400)

            body = JSON.parse(response.body)
            body['error'].should be_true
          end
        end
      end

      it 'generates and responds with an OAuth generated access token' do
        response.status.should eq(200)

        body = JSON.parse(response.body)
        body['error'].should be_false

        access_token = body['access_token']
        access_token.should_not be_blank

        tokens = Doorkeeper::AccessToken.where(
          :resource_owner_id => user.id, :application_id => oauth_app.id)
        tokens.count.should eq(1)

        token = tokens.first
        token.should_not be_expired
        token.should_not be_revoked
      end
    end
  end #credentials

end
