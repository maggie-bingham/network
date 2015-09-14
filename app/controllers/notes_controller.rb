class NotesController < ApplicationController

  def new
    @notes = Note.new
    respond_to do |format|
          format.html { }
          format.js { }
     end
  end

  def create
    @note = Note.new(note_params)
     @note.user_id = current_user.id
     respond_to do |format|
       if @note.save
         format.html { redirect_to notes_path, notice: 'Gif was successfully created.' }
         format.js { }
       else
         format.html { render :new }
         format.js {  }
       end
     end
  end

   def index
     @notes = Notes.where(current_user: current_user)
   end

   private

   def set_gif
      @note = Note.find(params[:id])
    end

    def note_params
      params.require(:note).permit(:user_id, :author_id, :body )
    end

end
