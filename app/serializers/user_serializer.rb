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
class UserSerializer < ActiveModel::Serializer
  has_one :role

  attributes :id,
             :uuid, 
             :name, 
             :lastname, 
             :email, 
             :dni,
             :rfid,
             :role,
             :plan_subscribed,
             :payments,
             :fingerprint

  def plan_subscribed
    {
      id: 1,
      name: "Platinum",
      price: 35,
      money: '$'
    }
  end

  def payments 
    [
      {
        id: 1,
        amount: 35.0,
        payment_date: (Date.today).strftime("%d/%m/%Y"),
        money: "$",
        name: "#{object.name + " " + object.lastname}"
      },
      {
        id: 2,
        amount: 35.0,
        payment_date: (Date.today).strftime("%d/%m/%Y"),
        money: "$",
        name: "#{object.name + " " + object.lastname}"
      }
    ]
  end
end
