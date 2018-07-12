class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.admin_email.subject
  #
  def admin_email
    @greeting = "Hi"

    mail to: "richardo4578@bigfoot.spokane.edu"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome_email.subject
  #
  def welcome_email
    @greeting = "Hi"

    mail to: "richardo4578@bigfoot.spokane.edu"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.article_email.subject
  #
  def article_email(user, article)
    # Put the user and article in instance variables so I can access them in the views
    @user = user
    @article = article

    mail subject: @article.title, to: @user.email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.contact_email.subject
  #
  def contact_email(name, email_address, phone_number, question, contact_type, product_selected, subscribed, notify)

    @name = name
    @email_address = email_address
    @phone_number = phone_number
    @question = question
    @contact_type = contact_type
    @product_selected = product_selected
    @subscribed = subscribed
    @notify = notify

    @user = User.where(name: 'admin', admin: true).first
    if ! @user.nil?
      mail subject: 'Contact Form Submission',
           to: @user.email,
           bcc: 'dave.jones@scc.spokane.edu'
    end

  end

  def contact_thank_you_email(name, email_address)

    @name = name

    mail subject: 'Thank you for contacting us!',
         to: email_address,
         bcc: 'dave.jones@scc.spokane.edu'

  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.product_email.subject
  #
  def product_email
    @greeting = "Hi"

    mail to: "richardo@bigfoot.spokane.edu"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.newsletter_email.subject
  #
  def newsletter_email
    @greeting = "Hi"

    mail to: "richardo@bigfoot.spokane.edu"
  end
end
