# == Schema Information
#
# Table name: exchanges
#
#  id         :bigint           not null, primary key
#  dolar      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Exchange < ApplicationRecord
end
