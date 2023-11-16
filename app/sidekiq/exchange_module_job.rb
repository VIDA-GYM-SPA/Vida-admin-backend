class ExchangeModuleJob
  include Sidekiq::Worker

  def perform(*args)
    RfidManager::change_rfid_to_ok
  end
end
