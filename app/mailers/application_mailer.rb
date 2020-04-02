# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@brownfieldteam.com'
  layout 'mailer'
end
