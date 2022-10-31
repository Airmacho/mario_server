FactoryBot.define do
  factory :client do
    name { "MyString" }
    age { 1 }
    private_note { "MyText" }
    address { "MyString" }
  end

  factory :client_peach, class: 'Client'  do
    name { 'Princess Peach' }
    age { 16 }
    private_note { 'nice and shine' }
    address { 'Mushroom Kingdom' }
  end

  factory :client_daisy, class: 'Client'  do
    name { 'Princess Daisy' }
    age { 15 }
    private_note { 'nice and shine' }
    address { 'Mushroom Kingdom' }
  end
end
