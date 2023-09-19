class ExchangeModuleJob
  include Sidekiq::Job

  def perform(*args)
    puts("TEST WARNING SEX")
  end
end
