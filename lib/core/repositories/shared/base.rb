# frozen_string_literal: true

module Base
  private

  def order_by_created_at(relation)
    relation
      .order { created_at.desc }
  end

  def with_relations(relation, *relation_names)
    relation
      .combine(*relation_names)
  end
end
