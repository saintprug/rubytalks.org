# frozen_string_literal: true

RSpec.describe Web::Views::ApplicationLayout, type: :view do
  let(:exposures) { { format: :html, title: 'Home', flash: {} } }
  let(:template) { Hanami::View::Template.new('apps/web/templates/application.html.slim') }
  let(:layout) { described_class.new(template, exposures) }

  subject { layout.render }

  it 'contains application name' do
    is_expected.to include('Rubytalk')
  end
end
