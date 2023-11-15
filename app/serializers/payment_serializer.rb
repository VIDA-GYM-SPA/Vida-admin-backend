# == Schema Information
#
# Table name: payments
#
#  id           :bigint           not null, primary key
#  amount       :float
#  bank         :string
#  discount     :float
#  dni          :string
#  is_accepted  :boolean
#  method       :string
#  money        :string
#  payed_at     :date
#  phone        :string
#  process_date :string
#  reason       :string
#  reference    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_payments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class PaymentSerializer < ActiveModel::Serializer
  belongs_to :user

  attributes :id, :amount, :discount, :is_accepted, :payed_at, :reason
end
