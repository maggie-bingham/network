class NotesController < ApplicationController

  def create
    @note = Note.new(note_params)
    @note.author = current_user.id
end
