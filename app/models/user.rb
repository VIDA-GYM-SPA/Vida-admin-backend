# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  dni             :string
#  email           :string
#  fingerprint     :text
#  gender          :string
#  lastname        :string
#  name            :string
#  password_digest :string
#  permissions     :integer          default([]), is an Array
#  rfid            :string
#  status          :string
#  uuid            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  role_id         :bigint           not null
#
# Indexes
#
#  index_users_on_role_id  (role_id)
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#
class User < ApplicationRecord
  include AASM
  
  aasm :column => 'status' do
    state :unpayed, initial: true
    state :suscribed
    state :unsuscribed

    event :suscribed do
      transitions from: [:unpayed, :unsuscribed], to: :suscribed
    end

    event :unsuscribed do
      transitions from: [:suscribed, :unpayed], to: :unsuscribed
    end

    event :unpayed do
      transitions from: [:suscribed], to: :unpayed
    end
  end
  
  belongs_to :role

  has_many :payments
  # serialize :permissions, Array

  has_secure_password
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/missing-a.png"

  before_create :generate_uuid
  before_create :generate_rfid

  # validates_attachment_content_type :avatar, content_type: /\image\/.*\z/

  validates :email,
            presence: true,
            uniqueness: true

  validates :password,
            length: { minimum: 8 },
            if: -> { new_record? || !password.nil? }

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end

  def generate_rfid
    self.rfid = SecureRandom.hex(48)
  end
end
