class CrawlfishCustomerCareController < ApplicationController

   before_filter :and_go_login_required , :set_cache_buster

   respond_to :html, :js


  def index

	self.initialize_variables

  end


  def initialize_variables

	@from="phoneservice"

	@and_go_user_name = session[:login_name]

	@and_go_id = session[:and_go_id]

  end


  def new

	self.initialize_variables

	render ("crawlfish_customer_care/phone_service")

  end

  def edit

    self.initialize_variables

    @customer = CustomerCareEntries.find(params[:id])

    @customer_id = @customer.id

    @customer_comments = CustomerCareEntriesComments.where("customer_care_entries_id = ?",params[:id]).select("created_at AS last_date,comments").all

    @comments_to_display="";

    
    @customer_comments.each do |i|

	difference = (Date.today - i.last_date.to_date).to_i

	time_to_display = ""

	if difference == 0
		time_to_display = "just today"
	elsif difference == 1
		time_to_display = difference.to_s + " day ago"
	else
		time_to_display = difference.to_s + " days ago"
	end
	
	@comments_to_display += i.last_date.strftime("%d-%m-%Y")+ " at " +i.last_date.strftime("%H:%M") + " (" +time_to_display + "): " +i.comments.to_s + "\n"

    end

    render ("crawlfish_customer_care/edit")

  end


  def show

   self.initialize_variables

   @customers,@customers_size,@followup_customers_size,@non_followup_customers_size = CustomerCareEntries.show_customers()

  end


  def date_fetch

    @follow_up = params[:follow_up].to_i

    @chosen_date_fetch = params[:date_fetch].to_s

    @customers,@customers_size,@followup_customers_size,@non_followup_customers_size = CustomerCareEntries.get_date_fetch(@chosen_date_fetch,@follow_up)

    render_show

  end


  def phone_fetch

    @phone_number_fetch = params[:phone_fetch].to_i

    @customers,@customers_size,@followup_customers_size,@non_followup_customers_size = CustomerCareEntries.get_phone_fetch(@phone_number_fetch)

    render_show

  end

  def month

    @follow_up = params[:follow_up].to_i

    @chosen_month = params[:date][:month]

    @chosen_year = params[:date][:year]

    @customers,@customers_size,@followup_customers_size,@non_followup_customers_size = CustomerCareEntries.get_month(@chosen_month,@chosen_year,@follow_up)

    render_show

  end

  
  def range

    @follow_up = params[:follow_up].to_i

    @chosen_from_date = params[:from_date].to_s

    @chosen_to_date = params[:to_date].to_s

    @customers,@customers_size,@followup_customers_size,@non_followup_customers_size = CustomerCareEntries.get_range(@chosen_from_date,@chosen_to_date,@follow_up)

    render_show

  end


  def render_show

   self.initialize_variables

   render ("crawlfish_customer_care/show")

  end

 
  def evaluate

	self.initialize_variables

	if !params[:customer_name].nil?

	      customer_name = params[:customer_name].to_s

	end

	if !params[:customer_phone_no].nil?

	      customer_phone_no = params[:customer_phone_no].to_s

	end

	if !params[:customer_email].nil?

	      customer_email = params[:customer_email].to_s

	end

	if !params[:customer_city].nil?

	     customer_city = params[:customer_city].to_s

	end

	if !params[:customer_area].nil?

	      customer_area = params[:customer_area].to_s

	end

	if !params[:enquiry_type].nil?

	      enquiry_type = params[:enquiry_type].to_s

	end

	if !params[:category_enquired].nil?

	     category_enquired = params[:category_enquired].to_s

	end

	if !params[:product_enquired].nil?

	      product_enquired = params[:product_enquired].to_s

	end

	if !params[:shops_referred].nil?

	      shops_referred = params[:shops_referred].to_s

	end

	if !params[:followup].nil?

	      followup = params[:followup].to_s

	end

	if !params[:source].nil?

	      source = params[:source].to_s

	end

	if !params[:comments].nil?

	      comments = params[:comments].to_s

	end

	db_record_flag_1 = CustomerCareEntries.create(:customer_name => customer_name, :customer_phone_no => customer_phone_no, :customer_email => customer_email, :customer_city => customer_city, :customer_area => customer_area, :enquiry_type => enquiry_type, :category_enquired => category_enquired, :product_enquired => product_enquired, :shops_referred => shops_referred, :followup => followup, :source => source)

        
	if !db_record_flag_1.nil?
		
		id_Value = CustomerCareEntries.select("id").where("customer_phone_no = ?",customer_phone_no).last
		
		comments_Entries = CustomerCareEntriesComments.new

		comments_Entries.customer_care_entries_id = id_Value.id

		comments_Entries.customer_phone_no = customer_phone_no

		comments_Entries.comments = comments

		db_record_flag_2 = comments_Entries.save
	
		if !db_record_flag_2.nil?

			TestMailer.after_create_customer_care_entry(customer_name,customer_phone_no,customer_email,customer_city,customer_area,enquiry_type,category_enquired,product_enquired,shops_referred,followup,source,comments).deliver


			render "crawlfish_customer_care/crawlfish_customer_care_result", :locals => { :flash => "yes"}

		else

			render "crawlfish_customer_care/crawlfish_customer_care_result", :locals => { :flash => "no"}
		end
	else
		render "crawlfish_customer_care/crawlfish_customer_care_result", :locals => { :flash => "no"}
	end

  end


  def update

	self.initialize_variables

        if !params[:customer_id].nil?
	
		@customer_id = params[:customer_id].to_i

        end

	if !params[:customer_name].nil?

	      customer_name = params[:customer_name].to_s

	end

	if !params[:customer_phone_no].nil?

	      customer_phone_no = params[:customer_phone_no].to_s

	end

	if !params[:customer_email].nil?

	      customer_email = params[:customer_email].to_s

	end

	if !params[:customer_city].nil?

	     customer_city = params[:customer_city].to_s

	end

	if !params[:customer_area].nil?

	      customer_area = params[:customer_area].to_s

	end

	if !params[:enquiry_type].nil?

	      enquiry_type = params[:enquiry_type].to_s

	end

	if !params[:category_enquired].nil?

	     category_enquired = params[:category_enquired].to_s

	end

	if !params[:product_enquired].nil?

	      product_enquired = params[:product_enquired].to_s

	end

	if !params[:shops_referred].nil?

	      shops_referred = params[:shops_referred].to_s

	end

	if !params[:followup].nil?

	      followup = params[:followup].to_s

	end

	if !params[:source].nil?

	      source = params[:source].to_s

	end

	if !params[:comments].nil?

	      comments = params[:comments].to_s

	end

	db_record_flag_1 = CustomerCareEntries.where("id=?",@customer_id).update_all(:customer_name => customer_name, :customer_phone_no => customer_phone_no, :customer_email => customer_email, :customer_city => customer_city, :customer_area => customer_area, :enquiry_type => enquiry_type, :category_enquired => category_enquired, :product_enquired => product_enquired, :shops_referred => shops_referred, :followup => followup, :source => source)

        
	if !db_record_flag_1.nil?

		db_record_flag_2 = CustomerCareEntriesComments.create(:customer_care_entries_id => @customer_id, :customer_phone_no => customer_phone_no, :comments => comments)
	
		if !db_record_flag_2.nil?

			render "crawlfish_customer_care/crawlfish_customer_care_result", :locals => { :flash => "yes"}

		else

			render "crawlfish_customer_care/crawlfish_customer_care_result", :locals => { :flash => "yes"}

		end
	else
		render "crawlfish_customer_care/crawlfish_customer_care_result", :locals => { :flash => "yes"}
	end

  end


end

