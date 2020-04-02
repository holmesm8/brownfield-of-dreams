# frozen_string_literal: true

# :nocov:
class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@brownfieldteam.com'
  layout 'mailer'
end
# :nocov
