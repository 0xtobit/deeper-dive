class RiotApi
  def self.client
    RiotLolApi::Client.new do |config|
      config.region = 'na'
      config.api_key = ENV['RIOT_API_KEY']
    end
  end
end
