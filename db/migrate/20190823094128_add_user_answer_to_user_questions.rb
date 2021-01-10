class AddUserAnswerToUserQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :user_questions, :user_answer, :string
  end
end
