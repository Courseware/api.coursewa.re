require 'spec_helper'

describe Coursewareable::Api::V1::LecturesController do
  let(:lecture) { Fabricate('coursewareable/lecture') }
  let(:token) do
    stub :accessible? => true,
    :resource_owner_id => lecture.classroom.owner.id
  end

  describe '#index' do
    before do
      controller.stub(:doorkeeper_token) { token }
      get(:index)
    end

    context 'authenticated' do
      its(:status) { should eq(200) }
      it 'should render lectures of classrooms that current user attend' do
        body = JSON.parse(response.body)
        body['lectures'].first['slug'].should eq(lecture.slug)
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
      get(:show, :id => lecture.id)
    end

    context 'authenticated' do
      its(:status) { should eq(200) }
      it 'should render requested lecture' do
        body = JSON.parse(response.body)
        body['lecture']['slug'].should eq(lecture.slug)
      end
    end

    context 'not authenticated' do
      let(:token) { stub(:accessible? => false) }

      its(:status) { should eq(401) }
    end
  end
end
