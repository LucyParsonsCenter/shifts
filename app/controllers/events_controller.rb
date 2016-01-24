class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def normal_shifts
    start_date = params[:start].to_date
    end_date = params[:end].to_date
    @shifts = Event.normal.where(start_time: start_date..end_date).distinct
    respond_to do |format|
      format.json { render json: @shifts.map(&:format) }
    end
  end

  def training_shifts
    start_date = params[:start].to_date
    end_date = params[:end].to_date
    @shifts = Event.training.where(start_time: start_date..end_date).distinct
    respond_to do |format|
      format.json { render json: @shifts.map(&:format) }
    end
  end

  def meetings
    start_date = params[:start].to_date
    end_date = params[:end].to_date
    @meetings = Event.meeting.where(start_time: start_date..end_date).distinct
    respond_to do |format|
      format.json { render json: @meetings.map(&:format) }
    end
  end

  def events
    start_date = params[:start].to_date
    end_date = params[:end].to_date
    @events = Event.event.where(start_time: start_date..end_date).distinct
    respond_to do |format|
      format.json { render json: @events.map(&:format) }
    end
  end

  def create_or_update
    if params["eventID"] == ""
      @event = Event.new
    else
      @event = Event.find_by_id(params["eventID"].to_i)
      @event.collective_members = []
      @event.trainees = []
    end
    @event.start_time = DateTime.parse("#{params["date"]}T#{params["startTime"]}")
    @event.end_time = DateTime.parse("#{params["date"]}T#{params["endTime"]}")

    get_notes
    add_collective_members_and_trainees
    case event_types(params["eventType"])
    when "Shift"
      @event.event_type = "shift"
    when "Training shift"
      @event.event_type = "training_shift"
    when "Meeting"
      @event.meeting = true
      @event.event_type = "meeting"
    when "Event!"
      @event.title = params["eventTitle"]
      @event.event_type = "event"
    end

    begin
      @event.save!
      render json: ["record saved correctly!"], status: 200

      if params["repeatTimes"].presence
        1.upto params["repeatTimes"].to_i - 1 do |i|
          event = @event.dup
          event.start_time = event.start_time + i.weeks
          event.end_time = event.end_time + i.weeks
          event.collective_members = @event.collective_members
          event.trainees = @event.trainees
          event.save!
        end
      end
    rescue ActiveRecord::RecordInvalid => err
      render json: ["Something didn't work out correctly: #{err}"], status: 422
    end
  end

  def show
    set_event
    event_response = {}
    event_response["date"] = @event.start_time.strftime('%Y-%m-%d')
    event_response["startTime"] = @event.start_time.strftime('%H:%M')
    event_response["endTime"] = @event.end_time.strftime('%H:%M')
    event_response
    case @event.event_type
    when "shift"
      event_response["eventType"] = '1'
    when "training_shift"
      event_response["eventType"] = '2'
      event_response["traineesMulti"] = @event.trainees.map(&:select_format)
    when "meeting"
      event_response["eventType"] = '3'
    when "event"
      event_response["eventType"] = '4'
      event_response["eventTitle"] = @event.title
    end
    event_response["collectiveMembersMulti"] = @event.collective_members.map(&:select_format)
    render json: event_response, status: 200
  end

  def event_types(num)
    types = { '1' => "Shift",
      '2' => "Training shift",
      '3' => "Meeting",
      '4' => "Event!"
    }
    types[num]
  end

  def destroy
    @event.destroy
    render json: ['destroyed'], status: 200
  end

  private

  def get_notes
    if params["notes"]
      @event.notes = params["notes"]
    end
  end

  def add_collective_members_and_trainees
    if params["trainees"]
      params["trainees"].each do |t|
        @event.trainees << Trainee.find(t.to_i)
      end
    end
    if params["collectiveMembers"]
      params["collectiveMembers"].each do |m|
        @event.collective_members << CollectiveMember.find(m.to_i)
      end
    end
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params[:event]
  end
end
