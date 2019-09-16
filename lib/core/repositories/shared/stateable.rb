# frozen_string_literal: true

module Stateable
  private

  def with_state(relation, state)
    relation.where(state: state)
  end

  def without_state(relation, given_state)
    relation.where { state.not(given_state) } # dunno how to use field and method argument with same name :(
  end
end
