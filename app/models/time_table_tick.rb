class TimeTableTick < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :tick_id, :time_table_id

  belongs_to :tick
  belongs_to :time_table

  validates :tick_id, :time_table_id, presence: true
  validates :tick_id, uniqueness: { scope: :time_table_id }
end
