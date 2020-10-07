# frozen_string_literal: true

require_relative '../lib/questioner'

RSpec.describe Questioner do
  let(:input) { double('Input') }
  let(:output) { double('Output') }
  subject(:questioner) { described_class.new(input, output) }
  let(:question) { 'Are you happy?' }

  describe '#ask' do
    %w[y Y YeS YES yes].each do |yes|
      it "returns true when parses #{yes}" do
        allow(output).to receive(:puts).with(question).once
        allow(input).to receive(:gets).and_return(yes).once

        expect(questioner.ask(question)).to eq(true)
      end
    end

    %w[n N no nO].each do |no|
      it "returns false when parses #{no}" do
        allow(output).to receive(:puts).with(question).once
        allow(input).to receive(:gets).and_return(no).once
        expect(questioner.ask(question)).to eq(false)
      end
    end

    [['y', true], ['n', false]].each do |input, state|
      it "continues asking for input until given #{input}" do

        %w[Note Yesterday xyzaty hot].each do |other|
          new_input = double('Input')
          new_output = double('Output')
          allow(new_input).to receive(:gets).and_return(other).once
          allow(new_output).to receive(:puts).with(question).once

          new_questioner = described_class.new(input, output)
          expect(new_questioner.ask(question)).to eq("I don't understand.")
        end

        new_input = double('Input')
        new_output = double('Output')
        allow(new_input).to receive(:gets).and_return(input).once
        allow(new_output).to receive(:puts).with(question).once
        new_questioner = described_class.new(new_input, new_output)


        expect(new_questioner.ask(question)).to eq(state)
      end
    end
  end
end

