# == Schema Information
#
# Table name: notifications
#
#  id                         :bigint           not null, primary key
#  description                :text
#  is_pending                 :boolean          default(TRUE)
#  title                      :string
#  user_with_pendings_actions :integer          not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
require "test_helper"

class NotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
