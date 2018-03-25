require 'multi_xml'
require 'omniauth-oauth'
require 'oauth'

module OmniAuth
  module Strategies
    class Goodreads < OmniAuth::Strategies::OAuth
      option :client_options, {
        :site => 'https://www.goodreads.com',
        :authorize_url => 'https://www.goodreads.com/oauth/authorize',
        :token_url => 'https://www.goodreads.com/oauth/access_token'
      }

      def request_phase
        super
      end

      uid { raw_info['id'].to_s }

      info do
        {
          'name' => raw_info['name'],
          'nickname' => raw_info['link'].match(Regexp.new nickname_regex)[1],
          'user_name' => raw_info['user_name'],
          'image' => raw_info['image_url'],
          'about' => raw_info['about'],
          'location' => raw_info['location'],
          'website' => raw_info['website'],
        }
      end

      extra do
        {:raw_info => raw_info}
      end

      def nickname_regex
        'https?:\/\/(?:www\.)?goodreads\.com\/user\/show\/(.+)'
      end

      def raw_info
        if @raw_info.nil?
          MultiXml.parser = :rexml
          authenticated_user = MultiXml.parse(access_token.get('/api/auth_user').body)
          id = authenticated_user['GoodreadsResponse']['user']['id'].to_i
          response_doc = MultiXml.parse(access_token.get("/user/show/#{id}.xml?key=#{@consumer_key}").body)
          @raw_info = response_doc['GoodreadsResponse']['user']
        end

        @raw_info
      end
    end
  end
end
