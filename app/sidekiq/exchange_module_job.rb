class ExchangeModuleJob
  include Sidekiq::Worker

  def perform(*args)
    puts("TEST WARNING")
  end
end
