# This will guess the Fgc::Grade class
FactoryGirl.define do
  factory :fgc_grade, :class => Fgc::Grade do
    ignore do
      prediction nil
    end


    association :group, :factory => :fgc_group, :strategy => :build

    after(:build) do |object, evaluator|
      unless evaluator.prediction.nil?
        object.group.prediction = evaluator.prediction
      end
      object.group.save
    end
  end
end