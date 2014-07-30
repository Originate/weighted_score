module WeightedScore
  class Score
    attr_reader :scorable

    def initialize(scorable)
      @scorable = scorable
    end

    def calculate
      1
    end
  end
end
