class PageController < ApplicationController


  def contact_us
    @error = []
    @name = params["name"]
    @name_blank = false

    if @name == ""
      @name_blank = true
      @error.push("Name field is required!")
      #flash.now[:notice_blank_name] = "Flash error: name is blank"
      #"Flash error: name is blank"
    end

    @email_address = params["email_address"]
    @email_blank = false

    if @email_address == ""
      @email_blank = true
      @error.push("Email address field is required!")
      #flash.now[:notice_blank_email] = "Flash error: email address is blank"
    end

    flash.now[:error] = @error

    @phone_number = params["phone_number"]
    @question = params["question"]
    @contact_type = params["preferred_contact_type"]
    # @products_list = ["Carbonara", "Raviola", "Prosciutto", "Risotto", "Focaccia", "Parmigiana", "Gnocchi"]
    @products_list = Product.pluck(:name).uniq.sort_by { |word| word.downcase }
    @product_selected = params["products_list"]
    @subscribed = params["newsletter"] == "subscribed" ? true : false
    @notify = params["notifications"] == "notify" ? true : false
    @submit = params["commit"]

    if (@submit == "submit question")
      if !(@name_blank || @email_blank)
        # Send Contact Submission Email To Admin
        UserMailer.contact_email(@name, @email_address, @phone_number, @question, @contact_type, @product_selected, @subscribed, @notify).deliver_now
        # Send a Thank You email to User
        UserMailer.contact_thank_you_email(@name, @email_address).deliver_now
        flash[:notice] = "Thank you. Your contact form has been submitted."
      end
    end

  end

  def calendar
    @month = params[:month].to_i
    if @month == 0
      @month = Time.now.month
    end
    @year = params[:year].to_i
    if @year == 0
      @year = Time.now.year
    end
  end

end
