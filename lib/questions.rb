class Question < ActiveRecord::Base
    has_many :user_questions 
    has_many :users, through: :user_questions

    def most_common_answer
        self.options.max_by do |option|
            user_questions_with_option = self.user_questions.filter do |u_q|
                u_q.user_answer == option
            end
            user_questions_with_option.length
        end
    end

    def options
        [self.option_a, self.option_b, self.option_c]
    end

end