# this just adds some sample data to the dev environment

def fake_phone_number
  phone_number = String.new()
  1.upto 10 do
    phone_number << rand(10).to_s
  end
  phone_number
end

def generate_collective_member(n)
  CollectiveMember.create(first_name: "Joe#{n}", last_name: "Schmo#{n}", email_address: "joe_#{n}@example.com", phone_number: fake_phone_number, trainer: rand(2) == 1 ? true : false)
end

def generate_trainee(n)
  Trainee.create(first_name: "Place#{n}", last_name: "Holder#{n}", email_address: "place_#{n}@foo.ru", phone_number: fake_phone_number, notes: "")
end

1.upto 20 do |n|
  generate_trainee(n)
  generate_collective_member(n)
end
