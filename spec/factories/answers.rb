FactoryGirl.define do
  factory :answer do
    body 'Text of Answer'
    question
    user
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
    user
  end
end
