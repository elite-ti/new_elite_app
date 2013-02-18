class Address < ActiveRecord::Base
  has_paper_trail

  STATES = ['AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 
            'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 
            'SP', 'SE', 'TO']
  
  attr_accessible :complement, :number, :street, :suburb, :city, :state, :country, :cep

  has_one :student
end