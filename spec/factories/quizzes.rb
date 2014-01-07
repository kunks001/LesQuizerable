FactoryGirl.define do
	factory :quiz do
    # sequence(:title){ |n| "Quiz #{n}" }
    title "Example Quiz"
    questions { [ create(:question) ] }
  end

  factory :question do
  	question_text "Example Question"
    # sequence(:query){ |o| "question #{o}" }
    # answers { [ create(:correct_answer), 3.times.map { create(:wrong_answer) } ].flatten }
  end
end