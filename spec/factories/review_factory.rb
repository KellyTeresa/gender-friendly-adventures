FactoryGirl.define do
  factory :review do
    terminology 3
    bathrooms 3
    gv_staff false
    overall 3
    comment "It was okay. Nothing special. I was a little uncomfortable."
    user
    venue
  end
end
