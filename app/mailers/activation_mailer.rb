# frozen_string_literal: true

class ActivationMailer < ApplicationMailer
  def inform(user_params, user)
    @key = user.set_confirmation_token
    @user_name = "#{user_params[:first_name]} #{user_params[:last_name]}"
    mail(to: user_params[:email], subject: "#{@user_name} please activate your account!")
  end

  def protect_against_forgery?
    false
  end
end
