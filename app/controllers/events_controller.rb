class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def normal_shifts
    start_date = params[:start].to_date
    end_date = params[:end].to_date
    @shifts = Event.normal.where(start_time: start_date..end_date)
    respond_to do |format|
      format.json { render json: @shifts.map(&:format) }
    end
  end

  def training_shifts
    start_date = params[:start].to_date
    end_date = params[:end].to_date
    @shifts = Event.training.where(start_time: start_date..end_date)
    respond_to do |format|
      format.json { render json: @shifts.map(&:format) }
    end
  end

  def meetings
    start_date = params[:start].to_date
    end_date = params[:end].to_date
    @meetings = Event.meeting.where(start_time: start_date..end_date)
    respond_to do |format|
      format.json { render json: @meetings.map(&:format) }
    end
  end

  def create_or_update
    if params.include? "eventID"
      @event = Event.find_by_id(params["eventID"].to_i)
      @event.collective_members = []
      @event.trainees = []
    else
      @event = Event.new
    end
    @event.start_time = DateTime.parse("#{params["date"]}T#{params["startTime"]}")
    @event.end_time = DateTime.parse("#{params["date"]}T#{params["endTime"]}")

    case event_types(params["eventType"])
    when "Shift"
      params["collectiveMembers"].map do |m|
        @event.collective_members << CollectiveMember.find(m.to_i)
      end
    when "Training shift"
      params["collectiveMembers"].map do |m|
        @event.collective_members << CollectiveMember.find(m.to_i)
      end
      params["trainee"].map do |t|
        @event.trainees << Trainee.find(t.to_i)
      end
    when "Meeting"
      @event.meeting = true
    when "Event!"
      params["collectiveMembers"].map do |m|
        @event.collective_members << CollectiveMember.find(m.to_i)
      end
    end

    begin
      binding.pry
      @event.save!
      render json: ["record saved correctly!"], status: 200
    rescue ActiveRecord::RecordInvalid => err
      render json: ["Something didn't work out correctly: #{err}"], status: 422
    end
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
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params[:event]
  end
end
