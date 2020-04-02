# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
    user_a = current_user.id
    user_b = User.find_by(github_url: "https://github.com/#{params[:friend_html]}").id
    friendship = Friendship.new(user_id: user_a, friend_id: user_b)
    if friendship.save(user_id: user_a, friend_id: user_b)
      flash[:notice] = 'Added Friend'
      # else
      # Can't test post routes via capybara
      # flash[:error] =  'Friendship not made due to error!'
    end
    redirect_to dashboard_path
  end
end
