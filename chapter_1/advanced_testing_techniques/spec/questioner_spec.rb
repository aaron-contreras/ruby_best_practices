# frozen_string_literal: true

require_relative '../lib/questioner'

RSpec.describe Questioner do
  subject(:questioner) { described_class.new }

  describe '#yes_or_no' do
    %w[y Y YeS YES yes].each do |yes|
      it "returns true when parses #{yes}" do
        expect(questioner.yes_or_no(yes)).to eq(true)
      end
    end

    %w[n N no nO].each do |no|
      it "returns false when parses #{no}" do
        expect(questioner.yes_or_no(no)).to eq(false)
      end
    end

    %w[Note Yesterday xyzaty hot].each do |other|
      it "returns nil because #{other} is not a variant of 'yes' or 'no'" do
        expect(questioner.yes_or_no(other)).to be_nil
      end
    end
  end

  describe 'inquire_about_happines' do
    context "when gets 'yes'" do
      it "responds 'Good I'm Glad'" do
        allow(questioner).to receive(:ask).and_return(true)
        expect(questioner.inquire_about_happiness).to eq("Good I'm Glad")
      end
    end

    context "when gets 'no'" do
      it "responds 'That's Too Bad'" do
        allow(questioner).to receive(:ask).and_return(false)
        expect(questioner.inquire_about_happiness).to eq("That's Too Bad")
      end
    end
  end
end

