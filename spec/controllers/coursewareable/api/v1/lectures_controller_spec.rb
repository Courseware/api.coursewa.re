require 'spec_helper'

describe Coursewareable::Api::V1::LecturesController do

  routes { Coursewareable::Engine.routes }

  let(:lecture) { Fabricate('coursewareable/lecture') }
  let(:token) do
    double(:accessible? => true, :resource_owner_id => lecture.user.id)
  end

  before do
    controller.stub(:doorkeeper_token) { token }
  end

  describe '#index' do
    before do
      get(:index)
    end

    context 'authenticated' do
      its(:status) { should eq(200) }

      it 'renders user lecture' do
        body = JSON.parse(response.body)
        body['lectures'].first['slug'].should eq(lecture.slug)
      end
    end

    context 'not authenticated' do
      let(:token) { double(:accessible? => false) }

      its(:status) { should eq(401) }
    end
  end

  describe '#show' do
    let(:params) { {:id => lecture.id} }
    before do
      get(:show, params)
    end

    context 'authenticated' do
      its(:status) { should eq(200) }

      it 'renders requested lecture from user created lectures' do
        body = JSON.parse(response.body)
        body['lecture']['slug'].should eq(lecture.slug)
      end

      context 'classroom id provided' do
        let(:params) {{:id => lecture.id,:classroom_id => lecture.classroom.id}}

        it 'renders requested lecture from requested classroom' do
          body = JSON.parse(response.body)
          body['lecture']['slug'].should eq(lecture.slug)
        end
      end
    end

    context 'not authenticated' do
      let(:token) { double(:accessible? => false) }

      its(:status) { should eq(401) }
    end
  end
end
