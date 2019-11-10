module Util
  module Pagination
    class Prepare
      PER_PAGE = 20

      def call(input)
        page = normalize_page(input[:page])
        per_page = normalize_per_page(input[:per_page])

        offset = per_page * (page - 1)

        input.merge(limit: per_page, offset: offset)
      end

      private

      def normalize_page(page)
        [page || 1, 1].max
      end

      def normalize_per_page(per_page)
        (per_page || PER_PAGE).to_i
      end
    end
  end
end
