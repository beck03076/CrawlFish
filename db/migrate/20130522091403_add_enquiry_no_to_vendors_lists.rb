class AddEnquiryNoToVendorsLists < ActiveRecord::Migration
  def change
    add_column :vendors_lists, :enquiry_no, :string, :limit =>15
  end
end
