class Topic < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :hours, :itens, :name, :schedule_id

  belongs_to :schedule
  has_many :ticks, dependent: :destroy
  has_many :klazzes, through: :ticks

  validates :schedule_id, :name, :itens, :hours, presence: true
  validates :name, uniqueness: { scope: :schedule_id }
end
