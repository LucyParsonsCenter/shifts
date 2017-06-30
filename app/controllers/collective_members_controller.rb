class CollectiveMembersController < ApplicationController
  before_action :set_collective_member, only: [:show, :edit, :update, :destroy]

  def index
    @collective_members = CollectiveMember.all
    render :index
  end

  def show
    @collective_member = CollectiveMember.find_by_id(params["id"])
    render :show
  end

  def new
    @collective_member = CollectiveMember.new
  end

  def edit
  end

  def create
    @collective_member = CollectiveMember.new(collective_member_params)

    respond_to do |format|
      if @collective_member.save
        format.html { redirect_to @collective_member, notice: 'Collective member was successfully created.' }
        format.json { render :show, status: :created, location: @collective_member }
      else
        format.html { render :new }
        format.json { render json: @collective_member.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @collective_member.update(collective_member_params)
        format.html { redirect_to @collective_member, notice: 'Collective member was successfully updated.' }
        format.json { render :show, status: :ok, location: @collective_member }
      else
        format.html { render :edit }
        format.json { render json: @collective_member.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @collective_member.destroy
    respond_to do |format|
      format.html { redirect_to collective_members_url, notice: 'Collective member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_collective_member
    @collective_member = CollectiveMember.find(params[:id])
  end

  def collective_member_params
    params[:collective_member]
  end
end
