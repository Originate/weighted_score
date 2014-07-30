class CriteriaOne < WeightedScore::Score
  def calculate
    return 1 if scorable >= 10
    0
  end
end

class CriteriaTwo < WeightedScore::Score
  def calculate
    return 1 if scorable.even?
    0
  end
end

class CriteriaThree < WeightedScore::Score
  def calculate
    return 1 if scorable % 4 == 0
    0
  end
end

class Calculator < WeightedScore::WeightedScore
  score CriteriaOne => 0.5
  score CriteriaTwo => 0.25
  score CriteriaThree => 0.25
end
