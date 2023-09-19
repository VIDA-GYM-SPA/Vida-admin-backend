# == Schema Information
#
# Table name: services
#
#  id                  :bigint           not null, primary key
#  commercial_activity :string           not null
#  name                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  area_id             :bigint           not null
#
# Indexes
#
#  index_services_on_area_id  (area_id)
#
# Foreign Keys
#
#  fk_rails_...  (area_id => areas.id)
#
require "test_helper"

class ServiceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
