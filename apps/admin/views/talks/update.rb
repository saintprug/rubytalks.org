# frozen_string_literal: true

module Admin
  module Views
    module Talks
      class Update
        include Admin::View
        template 'talks/edit'

        def title
          'Edit Talk'
        end

        def form
          Form.new(
            :talk,
            routes.talk_path(id: talk.id),
            { talk: talk, speakers: talk.speakers, event: talk.event },
            method: :patch
          )
        end

        def submit_label
          'Update talk'
        end
      end
    end
  end
end
