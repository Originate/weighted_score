require 'spec_helper'

module WeightedScore
  describe Score do
    subject(:score) { Score.new nil }

    describe '#calculate' do
      it 'has a default calculate value of 1' do
        expect(score.calculate).to eq 1
      end
    end
  end
end
