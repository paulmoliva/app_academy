class NotesController < ApplicationController
  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    if @note.save
      redirect back
    else
      redirect back, notice: @note.errors.full_messages
    end
  end

  private

  def note_params
    params.require(:note).permit(:body)
  end
end
