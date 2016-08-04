class ChangeResponsesTable < ActiveRecord::Migration
  def change
    rename_column(:responses, :question_id, :answer_choice_id)
  end
end
