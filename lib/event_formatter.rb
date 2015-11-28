class EventFormatter

  def initialize(object)
    @object = object
  end

  def format
    event = Hash.new
    if @object.class == Meeting
      event["title"] = "Collective Meeting"
    else
      event["title"] = @object.collective_member.first_name
    end


