module Persistence
  module Relations
    class Events < ROM::Relation[:sql]
      schema(:events, infer: true) do
        associations do
          has_many :talks
        end
      end

      def with_state(state)
        where(state: state)
      end
    end
  end
end
