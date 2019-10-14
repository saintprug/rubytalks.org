# frozen_string_literal: true

module Parsers
  module Confreaks
    class TalkParser
      attr_reader :event_page, :talk_page

      def initialize(event_page, talk_page)
        @event_page = event_page
        @talk_page  = talk_page
      end

      def call
        {
          title:       title,
          description: description,
          talked_at:   talked_at,
          link:        link
        }
      end

      protected

      def title
        talk_page.css('.video-title').css('/a').text.strip
      end

      def description
        talk_page.css('.video-stats').text.strip
      end

      def talked_at
        begin
          DateTime.parse(event_page.css('.video-posted').first.css('strong').text.strip)
        rescue TypeError, ArgumentError
          nil
        end
      end

      def link
        html_link = talk_page.css('iframe').first&.attr(:src)

        if youtube_link?(html_link)
          video_link = "https://www.youtube.com/watch?v=#{html_link.scan(/.*\/([A-Za-z0-9\-_]+)\?.*/).flatten.first}"

          if video_link == 'https://www.youtube.com/watch?v='
            return nil
          end
          video_link
        else
          puts 'not YT link'
        end
      end

      private

      def youtube_link?(link)
        link.include?('youtube')
      end
    end
  end
end
