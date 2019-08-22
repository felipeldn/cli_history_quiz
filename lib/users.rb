class User < ActiveRecord::Base
    has_many :user_questions 
    has_many :questions, through: :user_questions

    def self.high_scores
        users = User.all.select {|user| user.score > 0}
        high_scores = users.sort_by{|user| user.score}.reverse
        high_scores.map {|user| "User: #{user.username}".bold.blue + " Score: #{user.score}/10".red}
    end

    def unanswered_questions
        Question.all.filter{|question| !self.question_ids.include?(question.id)}
    end

    def question_ids
        UserQuestion.all.filter{|user_question| user_question.user_id === self.id}.map{|user_question| user_question.question_id }
    end

end