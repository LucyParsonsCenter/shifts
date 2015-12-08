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
    binding.pry
    event = Event.new

    date = params["date"].to_date
    start_time = params["startTime"].to_time
    end_time = params["endTime"].to_time
    [start_time, end_time].each do |t|
      t.year = date.year
      t.day = date.day
      t.month = date.month
    end
    event.start_time = start_time
    event.end_time = end_time

    event_type = event_types(params["eventType"])
    if event_type == "Shift"
      params["collectiveMembers"].map do |m|
        event.collective_member << CollectiveMember.find(m.to_i)
      end
    elsif event_type == "Training shift"
      params["collectiveMembers"].map do |m|
        event.collective_member << CollectiveMember.find(m.to_i)
      end
      params["trainee"].map do |t|
        event.trainee << Trainee.find(t.to_i)
      end
    elsif event_type == "Meeting"
      event.meeting = true
    elsif event_type == "Event!"
      params["collectiveMembers"].map do |m|
        event.collective_member << CollectiveMember.find(m.to_i)
      end
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
