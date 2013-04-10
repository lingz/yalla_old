class CalendarsController < ApplicationController
  layout false
  # GET /calendars
  # GET /calendars.json

  def callback
  end

  def update
    @calendar = Calendar.find(1)
    if !@calendar.last_update || @calendar.last_update.advance(seconds: 5) < DateTime.now
      @calendar.last_update = DateTime.now
      update = Calendar.calendar_update
      render json: {success: true, update: update.to_s}
    else
      render json: {success: false, update: "Last update was too recently"}
    end
  end

  def attend
    @user = User.find(params[:user_id])
    @event = Event.find(params[:event_id])
    state = Calendar.add_person(@event, @user)
    if state == true
      render json: {success: true, params: params} 
    else
      render json: {success: false, params: params} 
    end
  end

  def index
    @calendars = Calendar.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @calendars }
    end
  end

  # GET /calendars/1
  # GET /calendars/1.json
  def show
    @calendar = Calendar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @calendar }
    end
  end

  # GET /calendars/new
  # GET /calendars/new.json
  def new
    @calendar = Calendar.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @calendar }
    end
  end

  # GET /calendars/1/edit
  def edit
    @calendar = Calendar.find(params[:id])
  end

  # POST /calendars
  # POST /calendars.json
  def create
    @calendar = Calendar.new(params[:calendar])

    respond_to do |format|
      if @calendar.save
        format.html { redirect_to @calendar, notice: 'Calendar was successfully created.' }
        format.json { render json: @calendar, status: :created, location: @calendar }
      else
        format.html { render action: "new" }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendars/1
  # DELETE /calendars/1.json
  def destroy
    @calendar = Calendar.find(params[:id])
    @calendar.destroy

    respond_to do |format|
      format.html { redirect_to calendars_url }
      format.json { head :no_content }
    end
  end
end
