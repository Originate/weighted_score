module WeightedScore
  class WeightedScore
    attr_reader :scorable

    def initialize(scorable)
      @scorable = scorable
    end

    def self.score_map
      @score_map ||= {}
    end

    def self.score(score_value)
      @score_map = score_map.merge score_value
    end

    def calculate
      self.class.score_map.keys.reduce(0) do |total, score|
        total += score.new(scorable).calculate * self.class.score_map[score]
      end
    end
  end
end
