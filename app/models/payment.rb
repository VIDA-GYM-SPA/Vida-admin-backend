# == Schema Information
#
# Table name: payments
#
#  id           :bigint           not null, primary key
#  amount       :float
#  bank         :string
#  discount     :float
#  is_accepted  :boolean
#  method       :string
#  money        :string
#  payed_at     :date
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
class Payment < ApplicationRecord
  belongs_to :user

  enum method: ["Pago Movil", "Efectivo", "Transferencia", "Binance", "Zelle"]

  enum bank: [
    # Nacionales
    "Mercantil",
    "Banco Occidental de Crédito",
    "Banco de Venezuela",
    "Banco nacional de crédito",
    "Banesco",
    "Banco Activo",
    "Banco microfinanciero",
    "Banco del Tesoro",
    "Banco de desarrollo económico y social de Venezuela",
    "Banco de la Fuerza Armada Nacional Bolivariana",
    "Banco Agrícola de Venezuela",
    "Banco de Comercio Exterior",
    "Banco de Exportación y Comercio",
    "Banco Industrial de Venezuela",
    "Banco Venezolano de Crédito",
    "Banco Sofitasa",
    "Banco Plaza",
    "Banco Exterior",
    "Banco Caroní",
    "Banco del Sur",
    "Banco Bicentenario",
    "Banco del Pueblo Soberano",
    "Banco de la Gente Emprendedora",
    "Banco de la Mujer",
    "Banco de la Economía Comunal",
    # Internacionales
    "Efectivo"
    # "Bank of America",
    # "JP Morgan Chase",
    # "Wells Fargo",
    # "Citigroup",
    # "Goldman Sachs",
    # "Morgan Stanley",
    # "U.S. Bancorp",
    # "TD Bank",
    # "PNC Financial Services",
    # "Capital One",
    # "Bank of New York Mellon",
    # "State Street Corporation",
    # "HSBC Bank USA",
    # "Charles Schwab Corporation",
    # "Ally Financial",
    # "BB&T",
    # "SunTrust Banks",
    # "American Express",
    # "Discover Financial",
    # "Synchrony Financial",
    # "Barclays",
    # "Deutsche Bank",
    # "Credit Suisse",
    # "BNP Paribas",
    # "UBS",
    # "Royal Bank of Scotland",
    # "Standard Chartered",
    # "Santander Bank",
    # "Mitsubishi UFJ Financial Group",
    # "Mizuho Financial Group",
    # "Sumitomo Mitsui Financial Group",
    # "Bank of China",
    # "China Construction Bank",
    # "Agricultural Bank of China",
  ]
end
