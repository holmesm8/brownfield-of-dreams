# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/activation_mailer
class ActivationMailerPreview < ActionMailer::Preview

  def inform_mailer
    ActivationMailer.inform({first_name: "Ryan"}, User.last)
  end

end
