class UserMailerPreview < ActionMailer::UserMailerPreview
  def account_activation #preview this email at localhost:3000/rails/mailers/user_mailer/account_activation
    user = User.first
    user.activation_token = User.new_token
    UserMailer.account_activation(user)
  end

  def password_reset  #preview this email at http://localhost:3000/rails/mailers/user_mailer/password_reset
    UserMailer.password_reset
  end
end