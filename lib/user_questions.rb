class UserQuestion < ActiveRecord::Base
    belongs_to :user
    belongs_to :question

    # def self.save_user_question
    #     new_user_question = UserQuestion.create(user_id: @current_user.id, question_id: @new_question.id)
    # end

end