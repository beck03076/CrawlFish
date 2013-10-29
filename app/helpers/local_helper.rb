module LocalHelper

 def send_coupon_code_mailer(product_id,sub_category_id,vendor_id,coupon_code,product_price)

    sub_category = (Subcategories.what_is_my_name(sub_category_id.to_i).flatten.join).chomp.downcase

    product_details,product_name,product_identifier = get_product_details_for_coupons(product_id,sub_category)

    customer_details = VendorCoupons.where("coupon_code = ?",coupon_code).select("customer_phone_number").first

    vendor_details = VendorsDetails.where("vendor_id = ?",vendor_id).first

    #Generate Coupon Code - Customer SMS Details
    vendor_info = truncate(vendor_details.vendor_name.strip+", "+vendor_details.vendor_branch.strip,:length=>38).gsub('...','').strip
    vendor_phone_no = vendor_details.vendor_phone

    #Generate Coupon Code - Customer SMS text
    @customer_message = "Dear Customer, Your request to buy "+product_name+" from "+vendor_info+", ph:"+vendor_phone_no+" is processed CouponCode:"+coupon_code.upcase+" Rs."+number_with_delimiter(product_price.to_i)+"/-"

    #Generate Coupon Code - Vendor SMS Details
    customer_phone_no = customer_details.customer_phone_number
    vendor_name = ""
    if vendor_details.vendor_contact_name.mb_chars.length > 10
        vendor_name = "Merchant"
    else
        vendor_name = vendor_details.vendor_contact_name
    end

    #Generate Coupon Code - Vendor SMS text
    @vendor_message = "Dear "+vendor_name+", Received an enquiry from "+customer_phone_no+" for "+product_name+" Rs."+number_with_delimiter(product_price.to_i)+"/- Kindly follow-up. CouponCode:"+coupon_code.upcase+" CrawlFish Support: +919551707070"

    #SMS initialization
    user_name = "transinfinity"
    password = "sector@1"

    @customer_message_url = URI::encode("http://www.smsintegra.com/smsweb/desktop_sms/desktopsms.asp?uid="+user_name+"&pwd="+password+"&mobile=91"+customer_phone_no+"&msg="+@customer_message+"&sid=CRAWLF&dtNow="+Time.new.to_s)

    @vendor_message_url = URI::encode("http://www.smsintegra.com/smsweb/desktop_sms/desktopsms.asp?uid="+user_name+"&pwd="+password+"&mobile=919843903076"+"&msg="+@vendor_message+"&sid=CRAWLF&dtNow="+Time.new.to_s)
    
    #Customer SMS initiation
    @customer_message_response = open(@customer_message_url).read
    @customer_message_response_code = @customer_message_response.split("-")[0].strip
    

    #Vendor SMS initiation
    @vendor_message_response = open(@vendor_message_url).read
    @vendor_message_response_code = @vendor_message_response.split("-")[0].strip
    
    if(!product_details.nil? && !customer_details.nil? && !vendor_details.nil?)
    
        TestMailer.after_generate_coupon_code(product_name,product_identifier,product_price,customer_details.customer_phone_number,coupon_code,vendor_details.vendor_name,vendor_details.vendor_phone,vendor_details.vendor_city,vendor_details.vendor_branch,@customer_message,@customer_message_response,@customer_message_response_code,@vendor_message,@vendor_message_response,@vendor_message_response_code).deliver

    end
 end


 def get_product_details_for_coupons(product_id,sub_category)
    
    if(sub_category == "mobiles_lists")

        product_details = MobilesLists.where("mobiles_list_id = ?",product_id).select("mobile_name,mobile_color").first
        product_name = truncate(product_details.mobile_name,:length=>33).gsub('...','').strip
        product_identifier = product_details.mobile_color

    elsif(sub_category == "books_lists")

        product_details = BooksLists.where("books_list_id = ?",product_id).select("book_name").first
        product_name = truncate(product_details.book_name,:length=>33).gsub('...','').strip
        product_identifier = product_details.isbn13

    elsif(sub_category == "laptops_lists")

        product_details = LaptopsLists.where("laptops_list_id = ?",product_id).select("laptop_name,laptop_part_no").first
        product_name = truncate(product_details.laptop_name,:length=>33).gsub('...','').strip
        product_identifier = product_details.laptop_part_no

    elsif(sub_category == "desktops_lists")

        product_details = DesktopsLists.where("desktops_list_id = ?",product_id).select("desktop_name,desktop_part_no").first
        product_name = truncate(product_details.desktop_name,:length=>33).gsub('...','').strip
        product_identifier = product_details.desktop_part_no

    elsif(sub_category == "external_hdds_lists")

        product_details = ExternalHddsLists.where("external_hdds_list_id = ?",product_id).select("external_hdd_name,external_hdd_part_no").first
        product_name = truncate(product_details.external_hdd_name,:length=>33).gsub('...','').strip
        product_identifier = product_details.external_hdd_part_no

    elsif(sub_category == "printers_lists")

        product_details = PrintersLists.where("printers_list_id = ?",product_id).select("printer_name,printer_model_name").first
        product_name = truncate(product_details.printer_name,:length=>33).gsub('...','').strip
        product_identifier = product_details.printer_model_name

    elsif(sub_category == "routers_lists")

        product_details = RoutersLists.where("routers_list_id = ?",product_id).select("router_name,router_part_no").first
        product_name = truncate(product_details.router_name,:length=>33).gsub('...','').strip
        product_identifier = product_details.router_part_no

    elsif(sub_category == "mouses_lists")

        product_details = MousesLists.where("mouses_list_id = ?",product_id).select("mouse_name,mouse_part_no").first
        product_name = truncate(product_details.mouse_name,:length=>33).gsub('...','').strip
        product_identifier = product_details.mouse_part_no

    elsif(sub_category == "keyboards_lists")

        product_details = KeyboardsLists.where("keyboards_list_id = ?",product_id).select("keyboard_name,keyboard_part_no").first
        product_name = truncate(product_details.keyboard_name,:length=>33).gsub('...','').strip
        product_identifier = product_details.keyboard_part_no

    elsif(sub_category == "speakers_lists")

        product_details = SpeakersLists.where("speakers_list_id = ?",product_id).select("speaker_name,speaker_part_no").first
        product_name = truncate(product_details.speaker_name,:length=>33).gsub('...','').strip
        product_identifier = product_details.speaker_part_no

    elsif(sub_category == "memory_cards_lists")

        product_details = MemoryCardsLists.where("memory_cards_list_id = ?",product_id).select("memory_card_name,memory_card_part_no").first
        product_name = truncate(product_details.memory_card_name,:length=>33).gsub('...','').strip
        product_identifier = product_details.memory_card_part_no

    elsif(sub_category == "pendrives_lists")

        product_details = PendrivesLists.where("pendrives_list_id = ?",product_id).select("pendrive_name,pendrive_part_no").first
        product_name = truncate(product_details.pendrive_name,:length=>33).gsub('...','').strip
        product_identifier = product_details.pendrive_part_no

    elsif(sub_category == "headphones_lists")

        product_details = HeadphonesLists.where("headphones_list_id = ?",product_id).select("headphone_name,headphone_part_no").first
        product_name = truncate(product_details.headphone_name,:length=>33).gsub('...','').strip
        product_identifier = product_details.headphone_part_no


    elsif(sub_category == "headsets_lists")

        product_details = HeadsetsLists.where("headsets_list_id = ?",product_id).select("headset_name,headset_part_no").first
        product_name = truncate(product_details.headset_name,:length=>33).gsub('...','').strip
        product_identifier = product_details.headset_part_no

    elsif(sub_category == "tablets_lists")

        product_details = TabletsLists.where("tablets_list_id = ?",product_id).select("tablet_name,tablet_part_no").first
        product_name = truncate(product_details.tablet_name,:length=>33).gsub('...','').strip
        product_identifier = product_details.tablet_part_no

    end

    [product_details,product_name,product_identifier]

 end


 def get_product_image(product_name,product_identifier,category)

    product_image_url = ""

    if(category=="mobiles_lists")
        product_image_url=MobilesLists.where("mobile_name = ? AND mobile_color = ?",product_name,product_identifier).map{|i| i.mobile_image_url}.flatten.join

    elsif(category=="books_lists")
        product_image_url=BooksLists.where("book_name = ? AND isbn13 = ?",product_name,product_identifier).map{|i| i.book_image_url}.flatten.join

    elsif(category=="laptops_lists")
        product_image_url=LaptopsLists.where("laptop_name = ? AND laptop_part_no = ?",product_name,product_identifier).map{|i| i.laptop_image_url}.flatten.join

    elsif(category=="desktops_lists")
        product_image_url=DesktopsLists.where("desktop_name = ? AND desktop_part_no = ?",product_name,product_identifier).map{|i| i.desktop_image_url}.flatten.join

    elsif(category=="external_hdds_lists")
        product_image_url=ExternalHddsLists.where("external_hdd_name = ? AND external_hdd_part_no = ?",product_name,product_identifier).map{|i| i.external_hdd_image_url}.flatten.join

    elsif(category=="printers_lists")
        product_image_url=PrintersLists.where("printer_name = ? AND printer_model_name = ?",product_name,product_identifier).map{|i| i.printer_image_url}.flatten.join

    elsif(category=="routers_lists")
        product_image_url=RoutersLists.where("router_name = ? AND router_part_no = ?",product_name,product_identifier).map{|i| i.router_image_url}.flatten.join

    elsif(category=="mouses_lists")
        product_image_url=MousesLists.where("mouse_name = ? AND mouse_part_no = ?",product_name,product_identifier).map{|i| i.mouse_image_url}.flatten.join

    elsif(category=="keyboards_lists")
        product_image_url=KeyboardsLists.where("keyboard_name = ? AND keyboard_part_no = ?",product_name,product_identifier).map{|i| i.keyboard_image_url}.flatten.join

    elsif(category=="speakers_lists")
        product_image_url=SpeakersLists.where("speaker_name = ? AND speaker_part_no = ?",product_name,product_identifier).map{|i| i.speaker_image_url}.flatten.join

    elsif(category=="memory_cards_lists")
        product_image_url=MemoryCardsLists.where("memory_card_name = ? AND memory_card_part_no = ?",product_name,product_identifier).map{|i| i.memory_card_image_url}.flatten.join

    elsif(category=="pendrives_lists")
        product_image_url=PendrivesLists.where("pendrive_name = ? AND pendrive_part_no = ?",product_name,product_identifier).map{|i| i.pendrive_image_url}.flatten.join

    elsif(category=="headphones_lists")
        product_image_url=HeadphonesLists.where("headphone_name = ? AND headphone_part_no = ?",product_name,product_identifier).map{|i| i.headphone_image_url}.flatten.join

    elsif(category=="headsets_lists")
        product_image_url=HeadsetsLists.where("headset_name = ? AND headset_part_no = ?",product_name,product_identifier).map{|i| i.headset_image_url}.flatten.join

    elsif(category=="tablets_lists")
        product_image_url=TabletsLists.where("tablet_name = ? AND tablet_part_no = ?",product_name,product_identifier).map{|i| i.tablet_image_url}.flatten.join

    end

    product_image_url

 end


end
