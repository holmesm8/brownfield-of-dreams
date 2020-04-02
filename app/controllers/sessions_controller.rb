# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    @user ||= User.new
    @key = params[:activation_key] if params.key?(:activation_key)
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def update
    user_info = request.env['omniauth.auth']
    current_user.update_column(:github_token, (user_info[:credentials][:token]).to_s)
    current_user.update_column(:github_url, (user_info[:extra][:raw_info][:html_url]).to_s)
    redirect_to dashboard_path
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user &.authenticate(params[:session][:password])
      if params[:session].key?(:activation_key)
        user.update_column(:email_confirm, true)
      end
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Looks like your email or password is invalid'
      render :new
    end
  end
end
