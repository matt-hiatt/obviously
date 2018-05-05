class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    
    @user = nil
    @step_num = 1

    if(session[:user_id].nil?)
      @user = User.new
    else
      @user = User.find(session[:user_id])
      @step_num = User.return_step_num(@user)
    end

    
  end

  # GET /users/1/edit
  def edit
  end

  def wizard
    @user = nil
    valid_user = true
    @step_num = 1

    if(session[:user_id].nil?)
      @user = User.new(user_params)
    else
      @user = User.find(session[:user_id])
      @step_num = User.return_step_num(@user)
      @user.attributes = user_params
    end

    valid_user, user_errors = @user.valid_user(@step_num)
    
    if(valid_user)
      @step_num += 1
      @user.save
      session[:user_id] = @user.id
    else
      user_errors.map{ |k,v| @user.errors[k] = v }
    end

    respond_to do |format|
      format.js { render :content_type => 'text/javascript' }
    end
  end

  def wipe_session
    session[:user_id] = nil
    respond_to do |format|
      format.js { render :content_type => 'text/javascript' }
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password, :first_name, :last_name)
    end
end
