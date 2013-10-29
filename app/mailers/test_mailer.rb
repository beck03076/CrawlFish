    class TestMailer < ActionMailer::Base

  default :from => "crawlfish.bot@gmail.com"
  
  def complain(type,name,email,c)
  
    @type=type
    @name=name
    @email=email
    @c=c
    mail(:to => "crawlfish.notification@gmail.com", :subject => "Complain - #{@type}")
  
  end
  
  def add_your_shop(type,shop,name,ph)
  
    @type=type
    @shop_name=shop
    @name=name
    @ph=ph
    mail(:to => "crawlfish.notification@gmail.com", :subject => "Add My shop!")
  
  end

  def price_log(out,path)
  
    @out = out
  
    attachments['errors.txt'] = File.read(path + '/errors.txt')
    
    attachments['success.txt'] = File.read(path + '/success.txt')
  
    mail(:to => "mothirajha.chandramohan@crawlfish.in", :subject => "Price Updater")    
  
  end
 
  def after_send_sms_email(sms_phone_number,sms_product_name,sms_product_identifier,vendor_name,vendor_branch_name,vendor_phone,customer_message,customer_message_response,customer_message_response_code,vendor_message,vendor_message_response,vendor_message_response_code)

     @sms_phone_number = sms_phone_number
     @sms_product_name = sms_product_name
     @sms_product_identifier = sms_product_identifier
     @sms_vendor_name = vendor_name
     @sms_vendor_branch_name = vendor_branch_name
     @sms_vendor_phone = vendor_phone
     @sms_customer_message = customer_message
     @sms_customer_message_response = customer_message_response
     @sms_customer_message_response_code = customer_message_response_code
     @sms_vendor_message = vendor_message
     @sms_vendor_message_response = vendor_message_response
     @sms_vendor_message_response_code = vendor_message_response_code

     mail(:to => "crawlfish.notification@gmail.com", :subject => "An entry through SEND SMS for CrawlFish!")

  end

  def after_speak_to_us_call(speaktous)

      @after_speaktous = speaktous

      mail(:to => "crawlfish.notification@gmail.com", :subject => "An entry through SPEAK TO US for CrawlFish!")

  end

  def after_edit_local_merchant_products

    mail(:to => "crawlfish.notification@gmail.com", :subject => "An entry for EDIT through local_merchant_products for CrawlFish!")

  end

  def after_delete_local_merchant_products

    mail(:to => "crawlfish.notification@gmail.com", :subject => "An entry for DELETE through local_merchant_products for CrawlFish!")

  end

  def after_create_local_merchant_products

    mail(:to => "crawlfish.notification@gmail.com", :subject => "An entry for CREATE through local_merchant_products for CrawlFish!")

  end

  def after_edit_local_price_list_products
    
    mail(:to => "crawlfish.notification@gmail.com", :subject => "An entry for EDIT through local_price_list_products for CrawlFish!")

  end

  def after_delete_local_price_list_products
    
    mail(:to => "crawlfish.notification@gmail.com", :subject => "An entry for DELETE through local_price_list_products for CrawlFish!")

  end

  def after_create_priority_requests(type)

    @after_business_type = type
    
    mail(:to => "crawlfish.notification@gmail.com", :subject => "An entry for MERCHANT CREATE through merchants_lists for CrawlFish!")

  end

  def after_create_merchants_password_requests

    mail(:to => "crawlfish.notification@gmail.com", :subject => "An entry for FORGOT PASSWORD through merchants_password_requests for CrawlFish!")

  end

  def after_create_gifts_customer_informations(gift_name,coupon_number,customer_name,customer_address,mobile_number,invoice_number)

     @nt_gift_name = gift_name

     @nt_coupon_number = coupon_number

     @nt_customer_name = customer_name

     @nt_customer_address = customer_address

     @nt_mobile_number = mobile_number

     @nt_invoice_number = invoice_number
      
     mail(:to => "crawlfish.notification@gmail.com", :subject => "An entry for GIFTS for CrawlFish!")

  end

  def after_generate_coupon_code(product_name,product_identifier,product_price,customer_phone_no,coupon_code,vendor_name,vendor_phone_no,vendor_city,vendor_branch,customer_message,customer_message_response,customer_message_response_code,vendor_message,vendor_message_response,vendor_message_response_code)

    @gcc_product_name = product_name
    @gcc_product_identifier = product_identifier
    @gcc_customer_phone_no = customer_phone_no
    @gcc_vendor_name = vendor_name
    @gcc_vendor_phone_no = vendor_phone_no
    @gcc_vendor_city = vendor_city
    @gcc_vendor_branch = vendor_branch
        @gcc_coupon_code = coupon_code
        @gcc_product_price = product_price.to_i
    @gcc_customer_message = customer_message
    @gcc_customer_message_response = customer_message_response
    @gcc_customer_message_response_code = customer_message_response_code
    @gcc_vendor_message = vendor_message
    @gcc_vendor_message_response = vendor_message_response
    @gcc_vendor_message_response_code = vendor_message_response_code

    mail(:to => "crawlfish.notification@gmail.com", :subject => "An entry for GENREATE COUPON CODE for CrawlFish!")

  end

 def after_create_customer_care_entry(customer_name,customer_phone_no,customer_email,customer_city,customer_area,enquiry_type,category_enquired,product_enquired,shops_referred,followup,how_source,comments)

    @ccc_customer_name = customer_name

    @ccc_customer_phone_no = customer_phone_no

    @ccc_customer_email = customer_email

    @ccc_customer_city = customer_city

    @ccc_customer_area = customer_area

    @ccc_enquiry_type = enquiry_type

    @ccc_category_enquired = category_enquired

    @ccc_product_enquired = product_enquired

    @ccc_shops_referred = shops_referred

    @ccc_followup = followup

    @ccc_how_source = how_source

    @ccc_misc = comments

    mail(:to => "crawlfish.notification@gmail.com", :subject => "An entry for CRAWLFISH CUSTOMER CARE for CrawlFish!")

 end

end
