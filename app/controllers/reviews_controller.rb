class ReviewsController < ApplicationController

  before_action :identify_review, only:[:show, :edit, :update, :destroy]

  def index
    @reviews = Review.includes(:user).order('created_at DESC')
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @review.comments.includes(:user)
    @good = Good.new
    @bookmark = Bookmark.new
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to root_path
  end

  private

  def review_params
    params.require(:review).permit(:item, :review_text, :price_range_id, :category_id, :evaluation_id, :user_id, {images: []}).merge(
      user_id: current_user.id)
  end

  def identify_review
    @review = Review.find(params[:id])
  end

end
