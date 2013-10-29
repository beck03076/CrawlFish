class CustomerCareEntries < ActiveRecord::Base


   def self.c_id(ph = nil,email = nil)
   
     if ph.blank?
       where(:customer_email => email)
     elsif email.blank?
       where(:customer_phone_no => ph)     
     else
       where("customer_phone_no = #{ph} OR customer_email = '#{email}'")
     end
   
   
   end

   def self.get_from_date

      select("min(date(created_at)) as dt").map{|i| i.dt }[0]

   end

   def self.get_to_date

      select("max(date(created_at)) as dt").map{|i| i.dt }[0]

   end

 
   def self.get_range(from_date,to_date,follow_up = 0)

     if follow_up == 0

        customers = find_by_sql("SELECT a.*,b.comments FROM customer_care_entries a INNER JOIN customer_care_entries_comments b ON a.id=b.customer_care_entries_id WHERE a.created_at BETWEEN'"+from_date+ "' AND '"+to_date +"' AND b.created_at = (select MAX(created_at) FROM customer_care_entries_comments c WHERE c.customer_care_entries_id=a.id)")

  customers_count = customers.count

    elsif follow_up == 1

        customers = find_by_sql("SELECT a.*,b.comments FROM customer_care_entries a INNER JOIN customer_care_entries_comments b ON a.id=b.customer_care_entries_id WHERE a.followup ='y' AND a.created_at BETWEEN'"+from_date+ "' AND '"+to_date +"' AND b.created_at = (select MAX(created_at) FROM customer_care_entries_comments c WHERE c.customer_care_entries_id=a.id)")

  customers_count = customers.count

    elsif follow_up == 2

        customers = find_by_sql("SELECT a.*,b.comments FROM customer_care_entries a INNER JOIN customer_care_entries_comments b ON a.id=b.customer_care_entries_id WHERE a.followup ='n' AND a.created_at BETWEEN'"+from_date+ "' AND '"+to_date +"' AND b.created_at = (select MAX(created_at) FROM customer_care_entries_comments c WHERE c.customer_care_entries_id=a.id)")

  customers_count = customers.count

    end

  followup_customers_count = CustomerCareEntries.where("followup=? AND created_at BETWEEN ? AND ?",'y',from_date,to_date).count 

  non_followup_customers_count = CustomerCareEntries.where("followup=? AND created_at BETWEEN ? AND ?",'n',from_date,to_date).count 

  return customers,customers_count,followup_customers_count,non_followup_customers_count

   end

   def self.get_month(month,year,follow_up = 0)

     if follow_up == 0

         customers = find_by_sql("SELECT a.*,b.comments FROM customer_care_entries a INNER JOIN customer_care_entries_comments b ON a.id=b.customer_care_entries_id WHERE MONTH(a.created_at)='"+month+"' AND YEAR(a.created_at)='"+year+"' AND b.created_at = (select MAX(created_at) FROM customer_care_entries_comments c WHERE c.customer_care_entries_id=a.id)")

  customers_count = customers.count

     elsif follow_up == 1

  customers = find_by_sql("SELECT a.*,b.comments FROM customer_care_entries a INNER JOIN customer_care_entries_comments b ON a.id=b.customer_care_entries_id WHERE a.followup='y' AND MONTH(a.created_at)='"+month+"' AND YEAR(a.created_at)='"+year+"' AND b.created_at = (select MAX(created_at) FROM customer_care_entries_comments c WHERE c.customer_care_entries_id=a.id)")

  customers_count = customers.count

     elsif follow_up == 2

         customers = find_by_sql("SELECT a.*,b.comments FROM customer_care_entries a INNER JOIN customer_care_entries_comments b ON a.id=b.customer_care_entries_id WHERE a.followup='n' AND MONTH(a.created_at)='"+month+"' AND YEAR(a.created_at)='"+year+"' AND b.created_at = (select MAX(created_at) FROM customer_care_entries_comments c WHERE c.customer_care_entries_id=a.id)")

  customers_count = customers.count

     end

  followup_customers_count = CustomerCareEntries.where("followup=? AND MONTH(created_at) =? AND YEAR(created_at)=?",'y',month,year).count 

  non_followup_customers_count = CustomerCareEntries.where("followup=? AND MONTH(created_at) =? AND YEAR(created_at)=?",'n',month,year).count

  return customers,customers_count,followup_customers_count,non_followup_customers_count

   end


   def self.get_date_fetch(date_fetch, follow_up = 0)


    if follow_up == 0


       customers = find_by_sql("SELECT a.*,b.comments FROM customer_care_entries a INNER JOIN customer_care_entries_comments b ON a.id=b.customer_care_entries_id WHERE DATE(a.created_at)='"+date_fetch+"' AND b.created_at = (select MAX(created_at) FROM customer_care_entries_comments c WHERE c.customer_care_entries_id=a.id)")

  customers_count = customers.count


    elsif follow_up == 1


  customers = find_by_sql("SELECT a.*,b.comments FROM customer_care_entries a INNER JOIN customer_care_entries_comments b ON a.id=b.customer_care_entries_id WHERE followup='y' AND DATE(a.created_at)='"+date_fetch+"' AND b.created_at = (select MAX(created_at) FROM customer_care_entries_comments c WHERE c.customer_care_entries_id=a.id)")

  customers_count = customers.count
     

    elsif follow_up == 2

       customers = find_by_sql("SELECT a.*,b.comments FROM customer_care_entries a INNER JOIN customer_care_entries_comments b ON a.id=b.customer_care_entries_id WHERE followup='n' AND DATE(a.created_at)='"+date_fetch+"' AND b.created_at = (select MAX(created_at) FROM customer_care_entries_comments c WHERE c.customer_care_entries_id=a.id)")

  customers_count = customers.count

    end

  followup_customers_count = CustomerCareEntries.where("followup=? AND DATE(created_at) =?",'y',date_fetch).count 

  non_followup_customers_count = CustomerCareEntries.where("followup=? AND DATE(created_at) =?",'n',date_fetch).count 

        return customers,customers_count,followup_customers_count,non_followup_customers_count

   end

   def self.get_phone_fetch(phone_number)

         customers = find_by_sql("SELECT a.*,b.comments FROM customer_care_entries a INNER JOIN customer_care_entries_comments b ON a.id=b.customer_care_entries_id WHERE a.customer_phone_no='"+phone_number.to_s+"' AND b.created_at = (select MAX(created_at) FROM customer_care_entries_comments c WHERE c.customer_care_entries_id=a.id)")

  customers_count = customers.count

  followup_customers_count = 0

  non_followup_customers_count = 0

  return customers,customers_count,followup_customers_count,non_followup_customers_count

   end

   def self.show_customers()

    customers = find_by_sql("SELECT a.*,b.comments FROM customer_care_entries a INNER JOIN customer_care_entries_comments b ON a.id=b.customer_care_entries_id WHERE b.created_at = (select MAX(created_at) FROM customer_care_entries_comments c WHERE c.customer_care_entries_id=a.id)")
  
    customers_count = customers.count

    followup_customers_count = CustomerCareEntries.where("followup=?",'y').count

    non_followup_customers_count = CustomerCareEntries.where("followup=?",'n').count
  
         return customers,customers_count,followup_customers_count,non_followup_customers_count
   end


end

