# frozen_string_literal: true

module AdminApi
  module Services
    class Talks
      include Import[
        prepare_pagination: 'util.pagination.prepare',
        list_for_approve: 'domains.talks.operations.list_for_approve'
      ]

      def unpublished(input)
        input = prepare_pagination.call(input)
        list_for_approve.call(input)
      end
    end
  end
end
