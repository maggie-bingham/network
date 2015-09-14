class NotesController < ApplicationController

  def new
    @notes = Note.new
    respond_to do |format|
          format.html { }
          format.js { }
     end
  end

   def index
     @notes = Note.where(user_id: user_id)
   end

end
