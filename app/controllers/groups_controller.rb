class GroupsController < ApplicationController  
  def index
    return unless current_user

    @user = current_user
    @groups = @user.groups.includes(:purchases)
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to groups_path, notice: 'Category was successfully created.' }
      else
        flash.now[:alert] = 'The arguments are invalid.'
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :icon)
  end
  end