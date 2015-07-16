class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def new

  end

  def create

  end
end
