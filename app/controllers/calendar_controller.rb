#encoding: utf-8

class CalendarController < ApplicationController
  # load_and_authorize_resource

  def index
    product_names = ['6º Ano', '7º Ano', '8º Ano', '1ª Série ENEM', '2ª Série ENEM']
    products = product_names.map do |product_name|
      ProductYear.find_by_name(product_name + ' - 2013')
    end    
    @exam_executions = SuperKlazz.where(product_year_id: products.map(&:id), campus_id: Campus.accessible_by(current_ability).map(&:id)).map(&:exam_executions).flatten.uniq
    # @dates = @exam_executions.map(&:datetime).map(&:to_date).uniq.sort
  end

  def attendance
  end
end
