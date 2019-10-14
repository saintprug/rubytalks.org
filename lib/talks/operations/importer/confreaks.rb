# frozen_string_literal: true

module Talks
  module Operations
    module Importer
      class Confreaks < Operation
        include Import[
                  talk_repo:         'repositories.talk',
                  speaker_repo:      'repositories.speaker',
                  event_repo:        'repositories.event',
                  talk_speaker_repo: 'repositiories.talks_speakers',
                ]

        CONFREAKS_URL = 'https://confreaks.tv'
        BUZZWORDS     = %w[ruby rails goruco .rb euruko].freeze

        def call
          document    = Nokogiri::HTML(open(CONFREAKS_URL, read_timeout: 20, open_timeout: 20))
          total_pages = document.css('.pagination').first.css('a')[8].text.to_i

          (1..total_pages).each do |page|
            puts "processing page #{page}"
            html_page   = Nokogiri::HTML(open("#{CONFREAKS_URL}/?page=#{page}", read_timeout: 20, open_timeout: 20))
            event_nodes = html_page.css('.event-isotope')
            ruby_events = event_nodes.select do |event_node|
              conf_name = event_node.css('.event-img').text.strip.downcase
              BUZZWORDS.any? { |word| conf_name.include?(word) }
            end

            # create events
            ruby_events.each_with_index do |ruby_event, i|
              puts "processing event ##{i}"

              event = Parsers::Confreaks::EventParser.new(ruby_event).call

              event                  = {}
              title                  = ruby_event.css('.event-img').text.strip
              year                   = title.scan(/.*([0-9]{4}).*/).flatten.first
              start_month, end_month = ruby_event.css('.event-box').css('h4').text.scan(/\s*([A-Za-z]+)\s+\d+(?<=\s-([A-Za-z]))?/).flatten.compact
              start_day, end_day     = ruby_event.css('.event-box').css('h4').text.scan(/([0-9]{1,2})(?<=.-([0-9]))?/).flatten.compact

              event[:name]       = title.gsub(/[0-9]+/, '').strip
              event[:started_at] = DateTime.parse("#{start_month} #{start_day} #{year}")
              event[:ended_at]   = end_day && end_month ? DateTime.parse("#{end_month} #{end_day} #{year}") : event[:started_at]

              # new_event = event_repo.find_or_create(event)
              next if ruby_event.css('.text-muted').text.downcase.include?('presentations available on youtube') || ruby_event.css('.text-muted').text.downcase.include?('0 available presentations')

              event_url  = "#{CONFREAKS_URL}#{ruby_event.css('.event-img').css('/a').first.attr(:href)}"
              event_page = Nokogiri::HTML(open(event_url, read_timeout: 20, open_timeout: 20))

              # for current event
              event = event_repo.find_or_create(event)

              event_page.css('.video').each_with_index do |talk_item, j|
                puts "processing talk ##{j}"
                talk             = {}
                speakers         = []
                talked_at        = talk_item.css('.video-posted').first.css('strong').text.strip
                talk[:talked_at] = DateTime.parse(talked_at) if talked_at.present?

                talk_url = talk_item.css('.video-image').css('/a').first&.attr(:href)
                puts "talk url is nil" if talk_url.nil?
                talk_page = Nokogiri::HTML(open("#{CONFREAKS_URL}#{talk_url}", read_timeout: 20, open_timeout: 20))

                talk_page.css('.video-presenters').css('/a').each do |speaker_link|
                  splitted_name = speaker_link.text.strip.split
                  first_name    = splitted_name[0]
                  if splitted_name.length == 3
                    middle_name = splitted_name[1]
                    last_name   = splitted_name[2]
                  else
                    middle_name = nil
                    last_name   = splitted_name[1]
                  end
                  speakers << { first_name: first_name, middle_name: middle_name, last_name: last_name }
                end

                if speakers.empty?
                  puts '=== speakers are empty ==='
                  puts "title url #{talk_url}"
                  puts "title title #{talk[:title]}"
                end
                talk[:title]       = talk_page.css('.video-title').css('/a').text.strip
                talk[:description] = talk_page.css('.video-stats').text.strip
                link               = talk_page.css('iframe').first&.attr(:src)
                puts "link is nil" if link.nil?
                if link
                  if link.include?('youtube')
                    talk[:link] = "https://www.youtube.com/watch?v=#{link.scan(/.*\/([A-Za-z0-9\-_]+)\?.*/).flatten.first}"
                    if talk[:link] == 'https://www.youtube.com/watch?v='
                      puts '=== link is missing ==='
                      puts "title url #{talk_url}"
                    end
                  else
                    puts 'not youtube'
                  end
                end


                speakers.map do |sp|
                  speaker_repo.find_or_create(sp)
                end

                talk_from_db = talk_repo.find_by_title(talk[:title])

                new_talk = nil
                if talk_from_db.nil?
                  if event
                    new_talk = talk_repo.create(talk.merge(event_id: event.id))
                  else
                    new_talk = talk_repo.create(talk)
                  end
                end

                if new_talk
                  speakers.each do |sp|
                    talk_speaker_repo.create(talk_id: new_talk.id, speaker_id: sp.id)
                  end
                end


                p talk
                p speakers
                puts '====='
              end
            end
          end
          puts 'complete'.upcase
        end
      end
    end
  end
end
