class UsersController < ApplicationController
  before_action :authenticate_dairy!
  before_action :set_user, only: [:edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = current_dairy.users.all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = current_dairy.users.new(user_params)
    @user.password = Devise.friendly_token.first(8)

    respond_to do |format|
      if @user.save
        format.html { redirect_to new_user_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
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
    # User callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_dairy.users.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :mobile, :address, :animal_type, :email)
    end
end
