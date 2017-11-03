FactoryGirl.define do
  factory :answer do
    body 'Text of Answer'
    question
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
  end
end
