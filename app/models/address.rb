class Address < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :complement, :number, :street, :suburb, :city, :state, :country, :cep

  has_one :student
end