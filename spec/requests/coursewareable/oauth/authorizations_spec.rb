require 'spec_helper'
require 'oauth2'

describe 'OAuth provider' do
  let(:user) { Fabricate(:confirmed_user) }
  let(:doorkeeper_app) { Fabricate(:doorkeeper_app) }

  let(:client) do
    OAuth2::Client.new(doorkeeper_app.uid, doorkeeper_app.secret) do |c|
      c.request :url_encoded
      c.adapter :rack, Rails.application
    end
  end

  context 'authenticates' do
    subject { client.password.get_token(user.email, 'secret') }

    it { should_not be_expired }
  end

  context 'fails authentication' do
    let(:token) { client.password.get_token(user.email, 'wrong secret') }

    it { expect{ token }.to raise_error(OAuth2::Error) }
  end

end
