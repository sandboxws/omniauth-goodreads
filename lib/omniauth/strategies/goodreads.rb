require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Goodreads < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'http://www.goodreads.com'
      }

      def request_phase
        super
      end

      uid { raw_info['id'].to_s }

      info do
        {
          'id' => id,
          'name' => user['name'],
          'user_name' => user['user_name'],
          'image_url' => user['image_url'],
          'about' => user['about'],
          'location' => user['location'],
          'website' => user['website'],
        }
      end

      extra do
        {:raw_info => raw_info}
      end

      def raw_info
        access_token.options[:mode] = :query
        @raw_info ||= access_token.get('/auth_user').parsed
      end
    end
  end
end

OmniAuth.config.add_camelization 'goodreads', 'Goodreads'
