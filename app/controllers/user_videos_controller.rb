# frozen_string_literal: true

class UserVideosController < ApplicationController
  def new; end

  def create
    if current_user.nil?
      flash[:notice] = 'Please Log In to Bookmark Videos'
      return redirect_to login_path
    end
    user_video = UserVideo.new(user_video_params)
    user_video.user_id = current_user.id
    if current_user.user_videos.find_by(video_id: user_video.video_id)
      flash[:error] = 'Already in your bookmarks'
    elsif user_video.save
      flash[:success] = 'Bookmark added to your dashboard!'
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def user_video_params
    params.permit(:video_id)
  end
end
