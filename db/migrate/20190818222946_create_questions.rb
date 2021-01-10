class CreateQuestions < ActiveRecord::Migration[5.2]
  
  def change
    create_table :questions do |t|
      t.string :question
      t.string :option_a
      t.string :option_b
      t.string :option_c
      t.string :correct_answer
      t.string :correct_answer_response
      t.string :wrong_answer_response
    #   t.string :bonus_question, default: nil
    #   t.string :bonus_answer, default: nil
    #   t.string :bonus_right_answer, default: nil
    #   t.string :bonus_wrong_answer, default: nil
    #   t.boolean :bonus, default: false
    #   t.integer :new_question_creator_id (use this so that users can't get their own question when doing the quiz)
    end
  end

end
