# == Schema Information
#
# Table name: roles
#
#  id               :bigint           not null, primary key
#  base_permissions :integer          default([]), is an Array
#  name             :string
#  uuid             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require "test_helper"

class RoleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
