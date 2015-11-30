# this script creates some fake events
# yes some of these methods are bad

def random_date_and_time
  date1 = Time.current.beginning_of_month
  date2 = Time.current.end_of_month
  random_time = Time.at((date2.to_f - date1.to_f)*rand + date1.to_f)
  {start: random_time, end: random_time + (60 * 60 * 3)}
end

def random_collective_member
  CollectiveMember.find(rand(CollectiveMember.all.length) + 1)
end

def random_trainee
  Trainee.find(rand(Trainee.all.length) + 1)
end

def random_normal_shift
  shift_time = random_date_and_time
  Event.create(collective_member: random_collective_member, start_time: shift_time[:start], end_time: shift_time[:end])
end

def random_training_shift
  shift_time = random_date_and_time
  Event.create(collective_member: random_collective_member, start_time: shift_time[:start], end_time: shift_time[:end], trainee: random_trainee)
end

def random_meeting
  shift_time = random_date_and_time
  Event.create(start_time: shift_time[:start], end_time: shift_time[:end], meeting: true)
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
