require 'rails_helper'

describe Transaction do
  context "validations" do
    it { is_expected.to validate_presence_of(:credit_card_number)}
    it { is_expected.to validate_presence_of(:result)}
    it { is_expected.to validate_presence_of(:invoice)}
  end

  context "associations" do
    it { is_expected.to belong_to(:invoice)}
  end
end