require 'pry'
require 'colorize'

class QuizCLI

    @current_user = nil
    @current_answer = nil
    @current_user_question = nil
    @new_question = nil

    def welcome_message
        puts "Welcome to History Quiz 101! Let's have some fun and take a trip through time!".bold
    end
     
    def find_user
        new_user = PROMPT.select("Do you have an account with us?", %w(Yes No))
        if new_user == "Yes"
        user_login

        elsif new_user == "No"
        create_user
        end
    end

    def user_login
        user_info = PROMPT.collect do
            key(:username).ask('username:', required: true)
            key(:password).mask('password:', required: true)
        end 
        @current_user = User.find_by(username: user_info[:username], password: user_info[:password])
        if @current_user.nil?
            puts "Invalid credentials!"
            sleep 2
            find_user
        else 
            puts "Login successful"
            @current_user
        end 
    end

    def create_user
        puts "Please enter your new credentials"
        user_attrs = PROMPT.collect do
            key(:username).ask('username:', required: true)
            key(:password).mask('password:', required: true)
        end 
        @current_user = User.create(**user_attrs)
        puts "Thanks for signing up! Get ready for some time-travelling!".bold.blue
        sleep 2
        @current_user
    end 

    def home_menu
        options = [
            {"Take a quiz" => -> do run_quiz end},
            {"View high scores" => -> do puts User.high_scores end},
            {"My score" => -> do current_score end},
            {"Update your account" => -> do update_user_account end}, 
            {"Quit" => -> do quit end}    
        ]
        PROMPT.select("Please choose from the below:", options)
    end

    def current_score
        if
            @current_user.score == 0
                puts "You haven't played yet.".bold.blue
        else
                puts "Your current score is: #{@current_user.score}/10".bold.blue     
        end
    end

    def random_question
        all_questions = @current_user.unanswered_questions
        @new_question = all_questions.sample
        
        puts "Question: #{@new_question.question}"
                        options = [
            {"a) #{@new_question.option_a}" => -> do @new_question.option_a end},
            {"b) #{@new_question.option_b}" => -> do @new_question.option_b end},
            {"c) #{@new_question.option_c}" => -> do @new_question.option_c end}     
            ]
            @current_answer = PROMPT.select("Please choose one of the options below:", options)   
    end

    def answer_responses
        if @current_user.score <= 3
            puts "*" * 70
            puts "Not your best try, much like my first project. #{@current_user.score}/10. But we can all learn from our mistakes. That's what history is all about! Have another go with another set of questions.".bold.blue
        elsif @current_user.score == 4
            puts "*" * 70
            puts "Not bad, #{@current_user.score}/10. Almost 50%. Keep reading and looking for history all around you. You seem to enjoy it.".bold.blue
        elsif @current_user.score == 5
            puts "*" * 70
            puts "Nice! You got #{@current_user.score}/10. You seem to enjoy a bit of history. Keep reading and looking for it all around you.".bold.blue
        elsif @current_user.score == 6
            puts "*" * 70
            puts "Nice. You got #{@current_user.score}/10. Keep having fun with history and pass your enthusiasm on to others. History is all around us.".bold.blue 
        elsif @current_user.score == 7
            puts "*" * 70
            puts "Great effort! You got #{@current_user.score}/10! See if you can get a higher score with a new set of questions.".bold.blue
        elsif @current_user.score == 8
            puts "*" * 70
            puts "Ahhh do I sense a history buff? Well done, you got #{@current_user.score}/10. Keep reading about history and looking out for hidden gems where ever you go. Make sure to check the high scores table.".bold.blue
        elsif @current_user.score == 9 
            puts "*" * 70
            puts "Ahhh, so close! #{@current_user.score}/10! Great try though. You seem to enjoy your history. Have another go with a new set of questions to see if you can get a perfect 10, and make sure to check out the high scores table.".bold.blue
        else @current_user.score == 10  
            puts "*" * 70  
            puts "Ding, ding, ding!".bold.blue 
            sleep(2)
            puts "We have a history buff!".bold.blue 
            sleep(2)    
            puts "Or a history student?".bold.blue 
            sleep(2)
            puts "Nice one, perfect #{@current_user.score}/10! See if you can replicate your score with a new set of questions and make sure to check out the high scores table.".bold.blue    
        end
    end

    def run_quiz
        question_count = 0
        @current_user.score = 0

        while question_count < 10 do 
    #Maybe I don't even need the string below if my #sleeps & answer.responses are are well placed
          puts "Get ready for a question.".bold.red
          sleep(1)
          random_question
            question_count += 1
            @current_user_question = UserQuestion.create(user_id: @current_user.id, question_id: @new_question.id)
            if @current_answer == @new_question.correct_answer
                puts @new_question.correct_answer_response
                sleep(2)
                @current_user.score += 1
                @current_user.save
                # binding.pry
            else
                puts @new_question.wrong_answer_response
                sleep(2)
            end
        end
        puts answer_responses
        sleep (2)
        puts "Thanks for taking the quiz! Hope you had fun time-travelling via my CLI app!" .bold.blue   
    end

    def update_username
        @current_user.update(username: PROMPT.ask("Input new username:", required: true))
    end
    
    def update_password
        @current_user.update(password: PROMPT.mask("Input new password:", required: true))
    end
     
    def delete_user_account        
        delete_user = PROMPT.select("Are you sure?".bold.red, %w(Yes No))
        if delete_user == "Yes"
                puts "Thanks for playing."
                sleep(1)
                puts "Your account has been deleted.".bold.red
                @current_user.delete
                sleep(2)
                exit!
    
            elsif delete_user == "No" 
        end
    end
     
    def update_user_account
        options = [
            {"Update your username" => -> do update_username end},
            {"Update your password" => -> do update_password end},
            {"Delete your account" => -> do delete_user_account end},
            {"Return to home menu" => -> do home_menu end}
        ]
        PROMPT.select("What would you like to update?", options)
    end

    def quit
        quit_app = PROMPT.select("Are you sure?".bold.red, %w(Yes No))
        if quit_app == "Yes"
                puts "Thank you for taking part in our quiz! Hope you enjoyed your trip through time!".bold.blue
                sleep(1)
                exit!
    
        elsif quit_app == "No" 
        end
    end
    
    def run
        quit = false
        welcome_message
        @user = nil
        while !quit
            @user = find_user
            while @user
                home_menu
        # binding.pry   
            end
        end
    end

end