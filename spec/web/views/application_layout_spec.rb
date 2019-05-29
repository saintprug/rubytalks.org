# frozen_string_literal: true

RSpec.describe Web::Views::ApplicationLayout, type: :view do
  subject { layout.render }

  let(:exposures) { { format: :html, title: 'Home', flash: {} } }
  let(:template) { Hanami::View::Template.new('apps/web/templates/application.html.slim') }
  let(:layout) { described_class.new(template, exposures) }

  # TODO: figure out why undefined method `template' for Class:Class occurs
  # it 'contains application name' do
  #   is_expected.to include('Rubytalks')
  # end
end
