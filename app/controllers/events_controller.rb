class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
      @events = Event.results(current_user.lat, current_user.lon)
        respond_to do |format|
          format.html
          format.json { render json: @event}
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render json: @event}
    end
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end


  def attend
    @event = Event.find(params[:id])
    @event.users << current_user
    @event.save!
      redirect_to :back
  end

  def unattend
    @event = Event.find(params[:id])
    @event.users.delete(current_user)
    redirect_to :back
  end
  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def rsvp
    event_member = @event.event_members.where(["invitee_id = ?", current_user.id])[0]
    if event_member
      event_member.rsvp_status = params[:rsvp_status]
    else
      event_member = @event.event_members.build({invitee: current_user, rsvp_status: :attending})
    end
    if event_member.save
      redirect_to @event, notice: 'Status was successfully updated.'
    else
      redirect_to @event, notice: 'Status could not be saved.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:events).permit(:id, :lat, :lon, :external_id, :group_name, :description, :date, :venue_name, :city, :state, :zipcode)
    end


  private

    # def categories(params)
    #   params.require(:events).permit(:lat, :lon, :city, :state, :name, :description, :picture, :time)
    # end
  end
