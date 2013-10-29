class SharedController < ApplicationController

  def tag
    
     t = params[:type].to_i
     
     if t == 0
     
       @t ="online."
     
     elsif t == 1
     
       @t ="in your area."
     
     end
  
     @p = Subcategories.order("RAND()").first.category_name.titleize

  end

  def submit_gift

    self.initialize_variables

    self.set_gifts_customer_informations

  end


  def set_gifts_customer_informations

    GiftsCustomerInformations.create(:gift_id => @customer_gift_id, :gift_name => @customer_gift_name.gift_name, :coupon_code => @coupon_number, :customer_name => @customer_name, :customer_address => @customer_address, :customer_phone_number => @mobile_number, :invoice_number => @invoice_number)

    TestMailer.after_create_gifts_customer_informations(@customer_gift_name.gift_name,@coupon_number,@customer_name,@customer_address,@mobile_number,@invoice_number).deliver

  end

  def initialize_variables

     if !(params[:customer_name].nil?)

    @customer_name = params[:customer_name].to_s

     end


     if !(params[:customer_address].nil?)

    @customer_address = params[:customer_address].to_s

     end


     if !(params[:mobile_number].nil?)

    @mobile_number = params[:mobile_number].to_s

     end


     if !(params[:invoice_number].nil?)

    @invoice_number= params[:invoice_number].to_s

     end


     if !(params[:coupon_number].nil?)

    @coupon_number = params[:coupon_number].to_s

     end

     if !(params[:gift_id].nil?)

    @customer_gift_id = params[:gift_id].to_s

    @customer_gift_name = Gifts.where("gift_id = ?",@customer_gift_id).select("gift_name").first

     end

  end

end
