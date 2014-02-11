FactoryGirl.define do
  factory :admin do
    initialize_with { new(attributes) }
  end

  factory :quiz do
    # sequence(:title){ |n| "Quiz #{n}" }
    title "Example Quiz"
    questions { [ create(:question) ] }
  end

  factory :question do
  	question_text "Example Question"
    # sequence(:query){ |o| "question #{o}" }
    answers { [ create(:correct_answer), 3.times.map { create(:wrong_answer) } ].flatten }
  end

  factory :correct_answer, :class => Answer do
    response "correct answer"
    correctness true
  end

  factory :wrong_answer, :class => Answer do
    sequence(:response){ |p| "wrong answer #{p}" }
    correctness false
  end
end