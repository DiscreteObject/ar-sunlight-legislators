class Congressperson < ActiveRecord::Base
  validate :massage_phone_numbers


  def massage_phone_numbers
    phone.gsub!(/[^\d]/,'')
    fax.gsub!(/[^\d]/,'')

  end

  def to_pp
    "  #{self.title} #{self.firstname} #{self.lastname}, #{self.party}-#{self.state}-#{self.district.to_s}"

  end


end
