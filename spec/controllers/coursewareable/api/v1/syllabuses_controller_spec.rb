require 'spec_helper'

describe Coursewareable::Api::V1::SyllabusesController do
  let(:syllabus) { Fabricate('coursewareable/syllabus') }
  let(:token) do
    stub :accessible? => true, :resource_owner_id => syllabus.classroom.owner.id
  end

  before do
    controller.stub(:doorkeeper_token) { token }
  end

  describe '#show' do
    before do
      get(:show, :classroom_id => syllabus.classroom.id)
    end

    context 'authenticated' do
      its(:status) { should eq(200) }

      it 'should render requested syllabus' do
        body = JSON.parse(response.body)
        body['syllabus'].first['title'].should eq(syllabus.title)
      end
    end

    context 'not authenticated' do
      let(:token) { stub(:accessible? => false) }

      its(:status) { should eq(401) }
    end
  end
end
