class NotesController < ApplicationController

  def new
    @notes = Note.new
    respond_to do |format|
          format.html { }
          format.js { }
     end
  end

  def create
        current_user.authored_notes << Note.new(note_params)
        respond_to do |format|
          format.html { redirect_to :back }
          format.js { render :new }
        end

  end

   def index
     @notes = Notes.where(current_user: current_user)
   end

   def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @topic, notice: 'Note was successfully updated' }
        format.json { render :show }
      else
        format.html { render :edit }
        format.json {  }
      end
    end
   end

   def show
     respond_to do |format|
       format.html
       format.json { render json: @note}
     end
   end

   def edit
   end

   def destroy
     @note = Note.find(params[:id])
      respond_to do |format|
        format.html { redirect_to user_url, notice: 'Note was successfully destroyed.' }
        format.json { head :no_content }
    end
  end



   private

   def set_note
      @note = Note.find(params[:id])
    end

    def note_params
      params.require(:note).permit(:user_id, :author_id, :body)
    end

end
