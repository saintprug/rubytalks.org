# frozen_string_literal: true

RSpec.describe Admin::Views::ApplicationLayout, type: :view do
  subject { layout.render }

  let(:layout) { described_class.new({ format: :html, title: 'Admin', flash: {} }, 'contents') }

  it 'contains application name' do
    is_expected.to include('Admin')
  end
end
