# frozen_string_literal: true

module ContainerExt
  module FileRegistration
    def register_file!(file)
      key = file.tr('/', '.')

      register(key) do
        class_name = file.camelize
        Object.const_get(class_name).new
      end
    end
  end
end
