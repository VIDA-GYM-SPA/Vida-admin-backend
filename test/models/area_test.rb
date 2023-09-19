# == Schema Information
#
# Table name: areas
#
#  id            :bigint           not null, primary key
#  can_access_by :integer          default([]), is an Array
#  is_protected  :boolean
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require "test_helper"

class AreaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
