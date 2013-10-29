#================================
# admin : integer/id
#--------
# Retail : Main branch location/area/branch id from branches table
# Online : Head office location of the company - name
#================================
# premium : 0/1
#--------
# Retail : Shops like univercell, mobile store and easy cell city are premium and not authorised - Cf decides
# Online : Shops like Flipkart, have to find a way to classify premium shops for online
#================================
# authorised : 0/1
#------------
# Retail : Shops like nokia priority dealer, samsung smartcafe, apple istore are authorised and premium - Cf decides which is both 
# Online : If in future nokia ,samsung and other manufacturers website starts selling, then its authorised
#================================
# cards : 0/1
#------------
# Retail : The shops that accepts card payments
# Online : The shops that has card payment facility during COD
#================================
# affiliate : 0/1
#------------
# Retail : The shops that generates revenue to Cf in any mode
# Online : The shops that generates revenue to Cf in any mode
#================================
class AddAdminAndPremiumAndAuthorisedAndCardsAndAffiliateToVendorsLists < ActiveRecord::Migration
  def change
    add_column :vendors_lists, :admin, :integer, :null => false
    add_column :vendors_lists, :premium, :integer, :default => 0
    add_column :vendors_lists, :authorised, :integer, :default => 0
    add_column :vendors_lists, :cards, :integer, :default => 0
    add_column :vendors_lists, :affiliate, :integer, :default => 0
  end
end
