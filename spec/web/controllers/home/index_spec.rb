# frozen_string_literal: true

RSpec.describe Web::Controllers::Home::Index do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'successfully returns :ok' do
    response = action.call(params)
    expect(response[0]).to be(200)
  end
end
