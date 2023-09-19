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
class RoleSerializer < ActiveModel::Serializer
  attributes :name, :permissions

  def permissions
    permissions = Permission.all
    result = []

    permissions.each do |item|
      object.base_permissions.map do |permission|
        if permission == item.id
          result << item
        end
      end
    end
    result.as_json(:except => [:created_at, :updated_at])
  end
end
