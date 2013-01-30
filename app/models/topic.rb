class Topic < ActiveRecord::Base
  has_paper_trail

  attr_accessible :itens, :name, :subject_id

  belongs_to :subject

  validates :name, :itens, :subject_id, presence: true
end
