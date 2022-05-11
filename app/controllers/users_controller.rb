class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:edit, :update]
  before_action :user_identify, only: [:edit,  :update, :show]

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_back(fallback_location: root_path)
    else
      render :edit
    end
  end

  def show
    @reviews = Review.includes(:@user).order(created_at: :desc)
    bookmarks = Bookmark.where(user_id: current_user.id)
    @bookmarks = Review.find(bookmarks.ids)
  end

  private

  def user_params
    params.require(:user).permit(:id, :nickname, :email, :image, :profile_text)
  end

  def user_identify
    @user = User.find(params[:id])
  end

end
