# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/admin_email
  def admin_email
    UserMailer.admin_email
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome_email
  def welcome_email
    UserMailer.welcome_email
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/article_email
  def article_email
    UserMailer.article_email
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/contact_email
  def contact_email
    UserMailer.contact_email
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/product_email
  def product_email
    UserMailer.product_email
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/newsletter_email
  def newsletter_email
    UserMailer.newsletter_email
  end

end
