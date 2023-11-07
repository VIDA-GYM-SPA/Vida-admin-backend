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

  after_save :broadcast_status_change
  
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

  def broadcast_status_change
    Notification.create(
      title: "Action-Needed", 
      description: 'A user has pending an action', 
      user_with_pendings_actions: self.id
    )

    ActionCable.server.broadcast("rfid", { 
      message: 'A user has pending an action', 
      type: "Action-Needed",
      user: self,
      username_parser: "#{self.name} #{self.lastname}",
      block_system: true,
      action_description: "User needs to take actions:\n1. Add RFID band.\n2. Add fingerprint",
      timestamps: Time.now
    })
  end

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end

  def generate_rfid
    self.rfid = SecureRandom.hex(48)
  end
end
