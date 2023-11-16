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
class Payment < ApplicationRecord
  belongs_to :user

  after_save :add_invoices

  validates :amount, presence: true
  validates :money, presence: true
  validates :reason, presence: true
  validates :method, presence: true
  validates :payed_at, presence: true
  validates :reference, presence: true
  validates :bank, presence: true

  # enum method: ["Pago Movil", "Efectivo", "Transferencia"]

  # enum bank: [
  #   # Nacionales
  #   "Mercantil",
  #   "Banco Occidental de Crédito",
  #   "Banco de Venezuela",
  #   "Banco nacional de crédito",
  #   "Banesco",
  #   "Banco Activo",
  #   "Banco microfinanciero",
  #   "Banco del Tesoro",
  #   "Banco de desarrollo económico y social de Venezuela",
  #   "Banco de la Fuerza Armada Nacional Bolivariana",
  #   "Banco Agrícola de Venezuela",
  #   "Banco de Comercio Exterior",
  #   "Banco de Exportación y Comercio",
  #   "Banco Industrial de Venezuela",
  #   "Banco Venezolano de Crédito",
  #   "Banco Sofitasa",
  #   "Banco Plaza",
  #   "Banco Exterior",
  #   "Banco Caroní",
  #   "Banco del Sur",
  #   "Banco Bicentenario",
  #   "Banco del Pueblo Soberano",
  #   "Banco de la Gente Emprendedora",
  #   "Banco de la Mujer",
  #   "Banco de la Economía Comunal",
  #   # Internacionales
  #   "Bank of America",
  #   # "JP Morgan Chase",
  #   # "Wells Fargo",
  #   # "Citigroup",
  #   # "Goldman Sachs",
  #   # "Morgan Stanley",
  #   # "U.S. Bancorp",
  #   # "TD Bank",
  #   # "PNC Financial Services",
  #   # "Capital One",
  #   # "Bank of New York Mellon",
  #   # "State Street Corporation",
  #   # "HSBC Bank USA",
  #   # "Charles Schwab Corporation",
  #   # "Ally Financial",
  #   # "BB&T",
  #   # "SunTrust Banks",
  #   # "American Express",
  #   # "Discover Financial",
  #   # "Synchrony Financial",
  #   # "Barclays",
  #   # "Deutsche Bank",
  #   # "Credit Suisse",
  #   # "BNP Paribas",
  #   # "UBS",
  #   # "Royal Bank of Scotland",
  #   # "Standard Chartered",
  #   # "Santander Bank",
  #   # "Mitsubishi UFJ Financial Group",
  #   # "Mizuho Financial Group",
  #   # "Sumitomo Mitsui Financial Group",
  #   # "Bank of China",
  #   # "China Construction Bank",
  #   # "Agricultural Bank of China",
  # ]

  def add_invoices
    redis = Redis.new

    return unless self.is_accepted

    months = { 
                1 => "ene",
                2 => "feb",
                3 => "mar",
                4 => "abr",
                5 => "may",
                6 => "jun",
                7 => "jul",
                8 => "ago",  
                9 => "sep",  
                10 => "oct",
                11 => "nov",
                12 => "dic"
             }

    parse_money = 0.0

    current_exchange = Exchange.last.dolar

    if self.money != '$'
      parse_money = self.amount / current_exchange
    else
      parse_money = self.amount
    end

    parsed_month = self.payed_at.strftime('%m').to_i
    parsed_year = self.payed_at.strftime('%Y').to_i

    if redis.get("invoices:#{parsed_year}") == nil
      redis.set("invoices:#{parsed_year}", '[]')
    end

    invoices = JSON.parse(redis.get("invoices:#{parsed_year}"))

    month_invoice = []

    if invoices.select { |item| item["month"] == months[parsed_month] }.length == 0
      month_invoice.push({
        month: months[parsed_month],
        year: parsed_year,
        month_invoices: 0,
        new_users: 0
      })

      invoices.push(month_invoice[0])

      redis.set("invoices:#{parsed_year}", invoices.to_json)
    end

    if redis.get("invoices:#{parsed_year}") != nil
      invoices = JSON.parse(redis.get("invoices:#{parsed_year}"))

      if invoices.select { |item| item["month"] == months[parsed_month] }.length > 0
        invoices.select { |item| item["month"] == months[parsed_month] }[0]["month_invoices"] += parse_money
        invoices.select { |item| item["month"] == months[parsed_month] }[0]["new_users"] += 0

        redis.set("invoices:#{parsed_year}", invoices.to_json)
      end
    end
  end
end
