module ModelsMethods
    
  module ClassMethods
  
   def get_display_name(feature_id)

    where("feature_id IN (?)", feature_id ).select("feature_name").map {|v| v.feature_name}

  end
  
   def get_identifier_from_id(product_id)

    find(product_id).identifier_slug

   end
  
    def use_identifier(name_var,name_val,id_var,id_val,identifier,s_c_id)

     # Checking the existence of the id in link_products_lists_vendors because, not all products in part-2 are there in part-1
     where("name_slug = ? AND #{id_var} IN (SELECT products_list_id FROM link_products_lists_vendors WHERE sub_category_id = #{s_c_id})",name_val).select(id_var+" , "+identifier).order(id_var).map{|i| [i.send(identifier).titlecase,i.send(id_var).to_i]}

    end 


    def m_columns(sub_category_name)
    #Postions List
    #0. Ids, 1.Brands, 2.Names, 3.Identifier1, 4.Image_url, 5.Availability_table_name,6.Features Index, 7. product_availability_flag, 8. Features to Display in generic results, 9. Price steps
    
  
        if sub_category_name == "mobiles_lists"

           return ["mobiles_list_id",
                   "mobile_brand",
                   "mobile_name",
                   "mobile_color",
                   "mobile_image_url",
                   "mobiles_vendor_f16_availabilities",
                   "1,3,4,5_version_names,9,10",
                   "mobile_availability_flag",
                   {2 => "type",3 => "form_factor",4 => "OS"},
                   [5000,10000,15000,20000,25000,30000,35000,40000]
                   ]

         elsif sub_category_name == "laptops_lists"

           return ["laptops_list_id",
                   "laptop_brand",
                   "laptop_name",
                   "laptop_part_no",
                   "laptop_image_url",
                   "laptops_vendor_f2_availabilities","1",
                   "laptop_availability_flag",
                   {0 => "Processor",1 =>"Ram", 2 =>"Hard_Disk", 3 =>"OS"},
                   [25000,30000,35000,40000,45000,50000,55000,60000]
                   ]

             elsif sub_category_name == "desktops_lists"

           return ["desktops_list_id",
                   "desktop_brand",
                   "desktop_name",
                   "desktop_part_no",
                   "desktop_image_url",
                   "desktops_vendor_f2_availabilities","1",
                   "desktop_availability_flag",
                   {0 => "Processor",1 =>"Ram", 2=>"Hard_Disk", 3 => "OS"},
                   [15000,20000,25000,30000,35000,40000,45000,50000]
                   ]
                   
              elsif sub_category_name == "external_hdds_lists"

           return ["external_hdds_list_id",
                   "external_hdd_brand",
                   "external_hdd_name",
                   "external_hdd_part_no",
                   "external_hdd_image_url",
                   "external_hdds_vendor_f2_availabilities","1",
                   "external_hdd_availability_flag",
                   {0 => "Capacity",1 =>"Connectivity", 2=>"Form_Factor"},
                   [3000,4000,5000,6000,7000,8000,9000,10000]
                   ]
                   
                   elsif sub_category_name == "printers_lists"

           return ["printers_list_id",
                   "printer_brand",
                   "printer_name",
                   "printer_model_name",
                   "printer_image_url",
                   "printers_vendor_f2_availabilities","1",
                   "printer_availability_flag",
                   {0 => "printing_method",1 =>"printing_output", 2=>"printing_functions"},
                   [2000,4000,6000,8000,10000,12000,14000,16000]
                   ]
             
             elsif sub_category_name == "headphones_lists"

           return ["headphones_list_id",
                   "headphone_brand",
                   "headphone_name",
                   "headphone_part_no",
                   "headphone_image_url",
                   "headphones_vendor_f2_availabilities","1",
                   "headphone_availability_flag",
                   {0 => "headphone_type",1 =>"wire", 2=>"headphone_jack"},
                   [500,1000,1500,2000,2500,3000,3500,4000,4500]
                   ]
            
            elsif sub_category_name == "headsets_lists"

           return ["headsets_list_id",
                   "headset_brand",
                   "headset_name",
                   "headset_part_no",
                   "headset_image_url",
                   "headsets_vendor_f2_availabilities","1",
                   "headset_availability_flag",
                   {0 => "headset_type",1 =>"wire", 2=>"headset_jack"},
                   [500,1000,1500,2000,2500,3000,3500,4000,4500]
                   ]
            
            elsif sub_category_name == "keyboards_lists"

           return ["keyboards_list_id",
                   "keyboard_brand",
                   "keyboard_name",
                   "keyboard_part_no",
                   "keyboard_image_url",
                   "keyboards_vendor_f2_availabilities","1",
                   "keyboard_availability_flag",
                   {0 => "color",2 =>"keys"},
                   [500,1000,1500,2000,2500,3000,3500,4000,4500]
                   ]
                   
             elsif sub_category_name == "memory_cards_lists"

           return ["memory_cards_list_id",
                   "memory_card_brand",
                   "memory_card_name",
                   "memory_card_part_no",
                   "memory_card_image_url",
                   "memory_cards_vendor_f2_availabilities","1",
                   "memory_card_availability_flag",
                   {0 => "memory_size",1 =>"card_class",2 => "card_speed"},
                   [500,1000,1500,2000,2500,3000,3500,4000,4500]
                   ]
                   
             elsif sub_category_name == "mouses_lists"

           return ["mouses_list_id",
                   "mouse_brand",
                   "mouse_name",
                   "mouse_part_no",
                   "mouse_image_url",
                   "mouses_vendor_f2_availabilities","1",
                   "mouse_availability_flag",
                   {0 => "connectivity",1 =>"technology",2 => "buttons"},
                   [500,1000,1500,2000,2500,3000,3500,4000,4500]
                   ]
                   
             elsif sub_category_name == "pendrives_lists"

           return ["pendrives_list_id",
                   "pendrive_brand",
                   "pendrive_name",
                   "pendrive_part_no",
                   "pendrive_image_url",
                   "pendrives_vendor_f2_availabilities","1",
                   "pendrive_availability_flag",
                   {0 => "color",1 =>"form_factor",2 => "connectivity"},
                   [200,400,600,800,1000,1200,1400,1600]
                   ]
                   
             elsif sub_category_name == "routers_lists"

           return ["routers_list_id",
                   "router_brand",
                   "router_name",
                   "router_part_no",
                   "router_image_url",
                   "routers_vendor_f2_availabilities","1",
                   "router_availability_flag",
                   {0 => "speed",1 =>"lan_ports",2 => "wan_ports",3 => "usb_ports", 4 => "antenna"},
                   [1000,2000,3000,4000,5000,6000,7000,8000]
                   ]
                   
            elsif sub_category_name == "speakers_lists"

           return ["speakers_list_id",
                   "speaker_brand",
                   "speaker_name",
                   "speaker_part_no",
                   "speaker_image_url",
                   "speakers_vendor_f2_availabilities","1",
                   "speaker_availability_flag",
                   {0 => "channel",1 =>"jack",2 => "amplifier",3 => "headphone_jack"},
                   [500,1000,1500,2000,2500,3000,3500,4000,4500]
                   ]       
                   
             elsif sub_category_name == "tablets_lists"

           return ["tablets_list_id",
                   "tablet_brand",
                   "tablet_name",
                   "tablet_part_no",
                   "tablet_image_url",
                   "tablets_vendor_f2_availabilities","1",
                   "tablet_availability_flag",
                   {0 => "processor",1 =>"graphics",2 => "ram",3 => "os", 4 => "memory_card_extend"},
                   [5000,10000,15000,20000,25000,30000,35000,40000]
                   ]                         

         end

    end
   
  end

  def self.included(receiver)

    receiver.extend ClassMethods

  end

  
end
