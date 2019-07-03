# frozen_string_literal: true

Container.boot(:persistence) do
  init do
    # TODO: add pagination
    # TalkRepository.enable_pagination!
  end
end
