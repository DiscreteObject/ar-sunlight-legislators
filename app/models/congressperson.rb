class Congressperson < ActiveRecord::Base
  validate :massage_phone_numbers


  def massage_phone_numbers
    phone.gsub!(/[^\d]/,'')
    fax.gsub!(/[^\d]/,'')

  end


end
