require 'spec_helper'

describe Coursewareable::Api::V1::ClassroomsController do
  let(:classroom) { Fabricate('coursewareable/classroom') }
  let(:token) do
    stub :accessible? => true,
    :resource_owner_id => classroom.owner.id
  end

  describe '#index' do
    before do
      controller.stub(:doorkeeper_token) { token }
      get(:index)
    end

    context 'authenticated' do
      its(:status) { should eq(200) }
      it 'should give information about classroom' do
        body = JSON.parse(response.body)
        body['classrooms'].first['title'].should eq(classroom.title)
      end
    end

    context 'not authenticated' do
      let(:token) { stub(:accessible? => false) }

      its(:status) { should eq(401) }
    end
  end

  describe '#show' do
    before do
      controller.stub(:doorkeeper_token) { token }
      get(:show, :id => classroom.id)
    end

    context 'authenticated' do
      its(:status) { should eq(200) }
      it 'should give information about requested classroom' do
        body = JSON.parse(response.body)
        body['classroom']['title'].should eq(classroom.title)
      end
    end

    context 'not authenticated' do
      let(:token) { stub(:accessible? => false) }

      its(:status) { should eq(401) }
    end
  end

  describe '#timeline' do
    before do
      controller.stub(:doorkeeper_token) { token }
      get(:timeline, :classroom_id => classroom.id)
    end

    context 'authenticated' do
      its(:status) { should eq(200) }
      it 'should render timeline for requested classroom' do
        body = JSON.parse(response.body)
        body['classrooms'].first['owner_id'].should eq(classroom.owner.id )
      end
    end

    context 'not authenticated' do
      let(:token) { stub(:accessible? => false) }

      its(:status) { should eq(401) }
    end
  end

  describe '#collaborators' do
    let!(:collaboration) { Fabricate('coursewareable/collaboration') }

    before do
      controller.stub(:doorkeeper_token) { token }
      get(:collaborators, :classroom_id => collaboration.classroom.id)
    end

    context 'authenticated' do
      its(:status) { should eq(200) }
      it 'should render collaborators and owner' do
        body = JSON.parse(response.body)['classroom']
        body['owner']['user']['email'].should(
          eq(collaboration.classroom.owner.email))
      end
    end

    context 'not authenticated' do
      let(:token) { stub(:accessible? => false) }

      its(:status) { should eq(401) }
    end
  end
end
