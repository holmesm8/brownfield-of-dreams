class SessionsController < ApplicationController
  def new
    # require 'pry'; binding.pry
    @user ||= User.new
    if params.has_key?(:activation_key)
      @key = params[:activation_key]
    end
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      if params[:session].has_key?(:activation_key)
        user.update_column(:email_confirm, true)
      end
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = "Looks like your email or password is invalid"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def update
    user_info = request.env['omniauth.auth']
    current_user.update_column(:github_token, "#{user_info[:credentials][:token]}")
    current_user.update_column(:github_url, "#{user_info[:extra][:raw_info][:html_url]}")
    redirect_to dashboard_path
  end
end
