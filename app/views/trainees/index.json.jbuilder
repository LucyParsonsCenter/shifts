json.array!(@trainees) do |trainee|
  json.extract! trainee, :id
  json.url trainee_url(trainee, format: :json)
end
