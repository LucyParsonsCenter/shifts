class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy]

  def index
    @shifts = Shift.all
  end

  def normal_shifts
    start_date = params[:start].to_date
    end_date = params[:end].to_date
    @shifts = Shift.normal.where(date_and_time: start_date..end_date)
    respond_to do |format|
      format.json { render json: @shifts }
    end
  end

  def training_shifts
    start_date = params[:start].to_date
    end_date = params[:start].to_date
    @shifts = Shift.training.where(date_and_time: start_date..end_date)
    binding.pry
    respond_to do |format|
      format.json { render json: @shifts }
    end
  end

  def new
    @shift = Shift.new
  end

  def edit
  end

  def create
    @shift = Shift.new(shift_params)

    respond_to do |format|
      if @shift.save
        format.html { redirect_to @shift, notice: 'Shift was successfully created.' }
        format.json { render :show, status: :created, location: @shift }
      else
        format.html { render :new }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @shift.update(shift_params)
        format.html { redirect_to @shift, notice: 'Shift was successfully updated.' }
        format.json { render :show, status: :ok, location: @shift }
      else
        format.html { render :edit }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @shift.destroy
    respond_to do |format|
      format.html { redirect_to shifts_url, notice: 'Shift was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shift
      @shift = Shift.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shift_params
      params[:shift]
    end
end
