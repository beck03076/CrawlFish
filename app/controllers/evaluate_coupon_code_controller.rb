class EvaluateCouponCodeController < ApplicationController

  def index

	
  end

  def evaluate

	exclusive_coupon_code = 0

	if !params[:exclusive_coupon_code].nil?

	      exclusive_coupon_code = params[:exclusive_coupon_code].to_s

	end

	if !params[:exclusive_coupon_vendor_id].nil?

	      exclusive_coupon_vendor_id = params[:exclusive_coupon_vendor_id].to_s

	end

	@coupon_code = exclusive_coupon_code

	@evaluate_coupon_code = ExclusiveCoupons.where("exclusive_coupon_code = ? AND exclusive_coupon_vendor_id = ?",exclusive_coupon_code,exclusive_coupon_vendor_id).first

	if !@evaluate_coupon_code.nil?

		self.write_coupon_code_in_file(@coupon_code,exclusive_coupon_vendor_id,"valid")

		render :partial => "evaluate_coupon_code/evaluate_coupon_code_result", :locals => { :flash => "yes"}

	else

		self.write_coupon_code_in_file(@coupon_code,exclusive_coupon_vendor_id,"invalid")

		render :partial => "evaluate_coupon_code/evaluate_coupon_code_result", :locals => { :flash => "no"}	
	
	end

  end	

  def write_coupon_code_in_file(coupon_code,vendor_id,flag)

	if(!File.exist?("public/exclusive_coupon_code/"+Date.today.to_s+"/"))

		FileUtils.mkdir_p("public/exclusive_coupon_code/"+Date.today.to_s+"/")

    	end

	search_log_session_id = request.session_options[:id]

	if !(coupon_code.nil?)

      		if(File.exist?("public/exclusive_coupon_code/"+Date.today.to_s+"/"+search_log_session_id+'.dat'))
	    		File.open("public/exclusive_coupon_code/"+Date.today.to_s+"/"+search_log_session_id+'.dat', 'a') {|f| f.write(@coupon_code.to_s + "|" + vendor_id + "|" + flag + "\n") }
    		else
    	    		File.open("public/exclusive_coupon_code/"+Date.today.to_s+"/"+search_log_session_id+'.dat', 'a') do |f|
		 	f.write(Time.new)
		 	f.write("\n" + @coupon_code.to_s + "|" + vendor_id + "|" + flag + "\n")
	    		end
    		end
	end
  end

end
