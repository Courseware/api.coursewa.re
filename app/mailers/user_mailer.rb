# Dummy user emails handler class (sends this to dalay_job)
class UserMailer < ActionMailer::Base
  default from: ::CoursewareAPI.config.default_email_address

  # Sends an activation email to the user
  #
  # @param user {User}, to send email to
  def activation_needed_email(user)
  end

  # Sends an activation confirmation email to the user
  #
  # @param user {User}, to send email to
  def activation_success_email(user)
  end

  # Sends a reset password email to the user
  #
  # @param user {User}, to send email to
  def reset_password_email(user)
  end

end
