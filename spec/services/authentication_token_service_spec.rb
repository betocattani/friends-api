# frozen_string_literal: true

require 'rails_helper'

describe AuthenticationTokenService do
  let(:token) { described_class.call }

  describe '.call' do
    it 'returns an authentication token' do
      user = create(:user)
      token = described_class.call(user.id)

      decoded_token = JWT.decode(
        token,
        described_class::HMAC_SECRET,
        true,
        { algorithm: described_class::ALGORITHM_TYPE }
      )

      expect(decoded_token).to eq(
        [
          { user_id: user.id },
          { alg: 'HS256' }
        ].as_json
      )
    end
  end
end
