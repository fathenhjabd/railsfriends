class FriendsController < ApplicationController
  before_action :set_friend, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:show] #if user is not authenticated, do not do any METHOD except index and show
  before_action :correct_user, only: [:edit, :update, :destroy] #for these methods stated, make sure the user is correct
  # GET /friends or /friends.json
  def index
    #@friends = Friend.all
    @friends  = Friend.paginate(:page => params[:page], :per_page=>5)
    if params[:q]
      @search_term = params[:search]
      @friends = @friends.search_by(@search_term)
    end
  end

  # GET /friends/1 or /friends/1.json
  def show
  end

  # GET /friends/new
  def new
    #@friend = Friend.new
    @friend = current_user.friends.build
  end

  # GET /friends/1/edit
  def edit
  end

  # POST /friends or /friends.json
  def create
    #@friend = Friend.new(friend_params)
    @friend = current_user.friends.build(friend_params)

    respond_to do |format|
      if @friend.save
        format.html { redirect_to @friend, notice: "Friend was successfully created." }
        format.json { render :show, status: :created, location: @friend }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friends/1 or /friends/1.json
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to @friend, notice: "Friend was successfully updated." }
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1 or /friends/1.json
  def destroy
    @friend.destroy
    respond_to do |format|
      format.html { redirect_to friends_url, notice: "Friend was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @friend = current_user.friends.find_by(id: params[:id]) #correct user is the current user who has been associated with this id
    redirect_to friends_path, notice: "Not Authorized to edit this friend" if @friend.nil? #if friend id is not equal to current user id, it would be nil (does not exist)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Only allow a list of trusted parameters through. Params are FORM FIELDS
    def friend_params
      params.require(:friend).permit(:first_name, :last_name, :email, :phone, :twitter, :user_id)
    end

end
