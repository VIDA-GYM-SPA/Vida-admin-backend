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

  attributes :uuid, 
             :name, 
             :lastname, 
             :email, 
             :dni,
             :rfid,
             :fingerprint,
             :user_permissions,
             

  def user_permissions
    permissions = Permission.all
    result = []

    permissions.map do |item|
      object.permissions.map do |permission|
        if permission == item.id
          result << item
        end
      end
    end
    result.as_json(:except => [:created_at, :updated_at])
  end
end
