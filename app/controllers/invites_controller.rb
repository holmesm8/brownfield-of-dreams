# frozen_string_literal: true

class InvitesController < ApplicationController
  def new; end

  def create
    # inviter = current_user.github_url.split('/').last
    github_api = GithubService.new
    inviter = github_api.user_info(current_user.github_url.split('/').last)
    user_hit = github_api.user_info(params[:invite][:github_handle])
    flash[:notice] = if !user_hit[:email].nil?
                       # InviteUserMailer.invite(inviter, user_hit).deliver_now
                       'Successfully sent invite!'
                     else
                       "The Github user you selected doesn't have an
      email address associated with their account."
                     end
    redirect_to dashboard_path
  end
end
