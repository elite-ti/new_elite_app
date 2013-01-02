class Tick < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :klazz_id, :topic_id, :delay_reason_id

  belongs_to :klazz
  belongs_to :topic
  belongs_to :delay_reason
  has_many :table_time_ticks, dependent: :destroy
  has_many :time_tables, through: :table_time_ticks

  validates :klazz_id, :topic_id, presence: true
  validates :topic_id, uniqueness: { scope: :klazz_id }
end
