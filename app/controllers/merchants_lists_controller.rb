class MerchantsListsController < ApplicationController
before_filter :set_city
layout false

  def new

    @merchants_list = MerchantsLists.new

  end

  def create

    merchants_home_preliminary_actions

    @type = params[:type].to_s

    puts "Im in merchants_lists/create"

    if @type == "local"

    puts "Im in merchants_lists/create.....LOCAL"

      @area = params[:area]
      @city = params[:city]

      @merchants_list = MerchantsLists.new(params[:merchants_lists])
      @merchants_list.business_type = @type
      @merchants_list.city_name = @city
      @merchants_list.branch_name = @area

    elsif @type == "online"

          puts "Im in merchants_lists/create....ONLINE"

      @merchants_list = MerchantsLists.new(params[:merchants_lists])
      @merchants_list.business_type = @type

    end

    #Senthil : 2012jun25 :  Added a if block to check whether the params[:upload] is nil?. This was added as a part of the merchant_logo file upload validation.

    if !(params[:upload].nil?)

      logo_path = General.data_file_upload(params[:upload],@merchants_list.merchant_name+"_logo")[2]

      @merchants_list.merchant_logo = logo_path

      Rails.logger.debug "inside if DEBUG ID - 98949 #{logo_path}" if Rails.logger.debug?

    end

          Rails.logger.debug "outside if DEBUG ID - 98949 #{logo_path}" if Rails.logger.debug?

    if @merchants_list.save
	
	TestMailer.after_create_priority_requests(@type).deliver

	@message = "Your request to become a vendor at CrawlFish has been taken, we will revert in 23 hours!"

	render 'merchants/success'

    else

        @error_flag = 1

        render 'merchants/home'

    end

  end

  def show_sign_up

    @merchants_list = MerchantsLists.new

    type_id = params[:type_id].to_i

    city_name = qualify_text_field(params[:city_name])

    area_name = qualify_text_field(params[:area_name])

    if type_id == 0

      @message = "Please select your business type!"

      render "merchants/message"

    elsif type_id == 1 && city_name == 0 && area_name == 0

      @message = "Please enter your city and area!"

      render "merchants/message"

    elsif type_id == 1 && area_name == 0

      @message = "Please enter your area!"

      render "merchants/message"

    elsif type_id == 1 && city_name == 0

      @message = "Please enter your city!"

      render "merchants/message"

    elsif type_id == 2

      @type = "online"

      render :partial => "merchants_lists/online_sign_up"

    else

        @type = "local"

        @city = params[:city_name].to_s

        @area = params[:area_name].to_s

        render :partial => "merchants_lists/local_sign_up"

    end

  end

  def qualify_text_field(text_field_name)

    if !(text_field_name.nil?)

      text_field_name_string = text_field_name.to_s

      text_field_name_string == "empty" ? 0 : text_field_name_string

    else

      0

    end

  end



end

