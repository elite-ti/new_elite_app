require 'spec_helper'

describe 'EmployeeSessions' do
  ['admin', 'campus_head_teacher'].each do |role|
    it "logs #{role} in" do
      send("log_#{role}_in")
      page.should have_content 'Logged in!'
    end
  end
end