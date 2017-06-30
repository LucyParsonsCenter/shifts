class TraineesController < ApplicationController
  def index
    @trainees = Trainee.all
    render :index
  end

  def show
    @trainee = Trainee.find_by_id(params["id"])
    render :show
  end

  def new
    @trainee = Trainee.new
    render :trainee_form
  end

  def edit
    @trainee = Trainee.find_by_id(params["id"])
    render :trainee_form
  end

  def create
    @trainee = Trainee.new(trainee_params)
    save_and_redirect
  end

  def update
    @trainee = Trainee.find_by_id(params["id"])
    save_and_redirect
  end

  def save_and_redirect
    @trainee.update(trainee_params)
    respond_to do |format|
      if @trainee.save
        format.html { redirect_to @trainee, notice: 'Trainee was successfully saved' }
      else
        if @trainee.id
          format.html { redirect_to @trainee, notice: 'Trainee was not saved, try again' }
        else
          format.html { redirect_to new_trainee_path, notice: 'Trainee not created, try again' }
        end
      end
    end
  end

  def destroy
    @trainee.destroy
    respond_to do |format|
      format.html { redirect_to trainees_url, notice: 'Trainee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def trainee_params
    params.require(:trainee).permit!
  end
end
