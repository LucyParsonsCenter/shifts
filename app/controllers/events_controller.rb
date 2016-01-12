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

    case event_types(params["eventType"])
    when "Shift"
      params["collectiveMembers"].each do |m|
        @event.collective_members << CollectiveMember.find(m.to_i)
      end
      @event.event_type = "shift"
    when "Training shift"
      params["collectiveMembers"].each do |m|
        @event.collective_members << CollectiveMember.find(m.to_i)
      end
      if params["trainees"]
        params["trainees"].each do |t|
          @event.trainees << Trainee.find(t.to_i)
        end
      end
      @event.event_type = "training_shift"
    when "Meeting"
      @event.meeting = true
      @event.event_type = "meeting"
    when "Event!"
      params["collectiveMembers"].each do |m|
        @event.collective_members << CollectiveMember.find(m.to_i)
      end
      @event.title = params["eventTitle"]
      @event.event_type = "event"
    end

    begin
      @event.save!
      render json: ["record saved correctly!"], status: 200
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
    if @event.meeting
      event_response["eventType"] = '3'
    elsif @event.trainees != []
      event_response["eventType"] = '2'
      event_response["traineesMulti"] = @event.trainees.map(&:select_format)
    elsif @event.title?
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

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params[:event]
  end
end
