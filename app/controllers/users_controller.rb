class UsersController < ApplicationController
  before_action :authenticate_user!,  except: [:user_profile]
  before_action :set_profile_user,  only: [:user_profile, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.where(:id=> current_user.id)  
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to "/users/edit", notice: 'Image was successfully uploaded.' }
        format.json { render :show, status: :ok, location: "/user/edit" }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def user_profile
     @apps = @user.public_apps
  end

  def send_email
      url = user_profile_url(current_user.id)
      ShareProfile.send_public_profile_url(params[:email_msg],url,current_user).deliver_now
      redirect_to :back
  end

  def notes
    unless params[:_method] == "get"
      notes_to_save = params[:notes]
      if notes_to_save
       notes_to_save = notes_to_save.gsub("\t", '').gsub("\r", '').strip
       current_user.update_attribute :notes, notes_to_save
      end
    end
    @notes = current_user.notes
  end

  def privacy
  end

  def terms_conditions
  end

  private

  def set_profile_user
     @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:avatar)
  end
end
