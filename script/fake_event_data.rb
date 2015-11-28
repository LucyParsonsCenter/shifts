# this script creates some fake events
# yes some of these methods are bad

def random_date_and_time
  date1 = Time.current.beginning_of_month
  date2 = Time.current.end_of_month
  Time.at((date2.to_f - date1.to_f)*rand + date1.to_f)
end

def random_collective_member
  CollectiveMember.find(rand(CollectiveMember.all.length) + 1)
end

def random_trainee
  Trainee.find(rand(Trainee.all.length) + 1)
end

def random_normal_shift
  Shift.create(collective_member: random_collective_member, date_and_time: random_date_and_time)
end

def random_training_shift
  Shift.create(collective_member: random_collective_member, date_and_time: random_date_and_time, trainee: random_trainee)
end

def random_meeting
  Meeting.create(date_and_time: random_date_and_time)
end

1.upto 100 do
  case rand(3)
  when 0
    random_normal_shift
  when 1
    random_training_shift
  when 2
    random_meeting
  end
end
