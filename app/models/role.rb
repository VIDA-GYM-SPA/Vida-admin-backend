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
class Role < ApplicationRecord
  has_many :users
  # serialize :base_permissions, Array

  before_create :generate_uuid

  validates :name, presence: true, uniqueness: true

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
