require 'httparty'

module Riot
  class Client
    def initialize(params)
    # def initialize(api_key=ENV['RIOT_API_KEY'], region='na1')
      # @api_key = params[:api_key]
      # @region = params[:region]
      @api_key = 'RGAPI-4b17652a-8235-4805-9115-25a0ca115302'
      @region = 'na1'
      @base_url = "https://#{@region}.api.riotgames.com/lol/"
      @developer_key = params[:developer_key] || true
    end

    def account_id(summoner_name)
      @account_id = get("summoner/v3/summoners/by-name/#{summoner_name}")['accountId']
      @account_id
    end

    def match_list(account_id=nil, query={})
      get("match/v3/matchlists/by-account/#{account_id || @account_id}", query)
    end

    def all_game_ids(account_id=nil, query={})
      game_ids = []
      begin_index = 0
      loop do
        resp = get("match/v3/matchlists/by-account/#{account_id || @account_id}", begin_index: begin_index)
        game_ids += resp['matches'].map { |m| m['gameId'] }
        begin_index = resp['startIndex']
        total_games = resp['totalGames']
        end_index = resp['endIndex']
        break if end_index >= total_games
        begin_index = end_index
      end
      game_ids
    end

    def match(match_id)
      get("match/v3/matches/#{match_id}")
    end

    # private

    def get(path, query={})
      # FIXME handle unexpected rate throttling
      if query.present?
        query_params = query.map { |k, v| URI.escape("#{k.to_s.camelcase(first_letter=:lower)}=#{v}") }.join('&')
      else
        query_params = ''
      end
      sleep(1.2) if @developer_key
      HTTParty.get("#{@base_url}#{path}?api_key=#{@api_key}&#{query_params}")
    end
  end
end
