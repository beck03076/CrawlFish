class MerchantsLists < ActiveRecord::Base

  validate :validate_merchant_logo

  validates :merchant_name, :presence => true,
                            :length => {:minimum => 3},

                            :format => { :with => /[A-Za-z0-9]+/ }

  validates :merchant_email, :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
                            

  validates :merchant_phone, :presence => true,
                             :numericality => true,
                             :length => { :minimum => 6 }


  validates :merchant_address, :presence => true,
                               :length => { :minimum => 10, :maximum => 500 }

  # Senthil: 2012jun25 : made changes to this model so that the merchant website and merchant fax are optional while signing up. Also added a validation for merchant logo.
  validates :merchant_website,
  #:presence => true,
                               :format => {:with => /(^((http|https):\/\/)?[a-z0-9]+([-.]{1}[a-z0-9]*)+.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/i}


  validates :merchant_fax,
  #:presence => true,
                            :numericality => true



  def validate_merchant_logo

      if merchant_logo.nil?
        errors.ad(:merchant_logo, "must be selected" )
      end

  end


end

