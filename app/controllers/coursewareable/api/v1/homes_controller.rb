module Coursewareable::Api::V1
  class HomesController < ApplicationController
    def show
      render :json => {:error => false}
    end
  end
end
