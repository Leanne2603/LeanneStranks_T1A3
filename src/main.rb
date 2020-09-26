require 'rainbow'
require 'csv'
require 'json'
require 'tty-prompt'
require_relative 'classes/userclass'
require_relative 'classes/quizquestionsclass'
prompt = TTY::Prompt.new


# Login authentication
puts "Welcome to Quiz Bites!"
puts "A place where you can test your skills and expand your mind with multiple choice quizzes"
puts "Please enter your username:"
input_username = gets.chomp
input_password = prompt.mask("Please enter your password:")
list_of_users = JSON.parse(File.read("src/users.json"), symbolize_names: true)
if list_of_users[0][:username] == input_username && list_of_users[0][:password] == input_password
    if list_of_users[0][:accesslevel] == "Facilitator"
        loop do
            # Menu for super user
        superuser_menu = prompt.select("Please select what you would like to do from the following options:") do |superusermenu|
            superusermenu.choice 'Create New User'
            superusermenu.choice 'View Existing Users'
            superusermenu.choice 'Create New Questions'
            superusermenu.choice 'View Existing Quizzes'
            superusermenu.choice 'Exit Program'
            end
            if superuser_menu == "Create New User"
                puts "What is the new user's full name?"
                input_new_user = gets.chomp
                puts "What username would you like to assign to this user?"
                input_new_username = gets.chomp
                puts "Assign a password for this user:"
                input_new_password = gets.chomp
                input_is_newuser_superuser = prompt.select("Is this new user a Facilitator or Student?") do |accesslevel|
                accesslevel.choice 'Facilitator'
                accesslevel.choice 'Student' 
                # Need to be able to write to file!    
                end
            elsif superuser_menu == "View Existing Users"
                puts list_of_users
            elsif superuser_menu == "Create New Questions"
                input_new_quiz_questions = prompt.select("Please select which subject you wish to add to:") do |newq|
                    newq.choice 'English'
                    newq.choice 'Science'
                    newq.choice 'History'
                end
                puts "In the next steps, you will be asked to enter your quiz question followed by 4 possible answers. You will then be asked to advise which is the correct answer"
                if input_new_quiz_questions == "English"
                        puts "Enter your new quiz question"
                        englishnewquizq = gets.chomp
                        puts "Enter possible answer 1:"
                        englishans1 = gets.chomp
                        puts "Enter possible answer 2:"
                        englishans2 = gets.chomp
                        puts "Enter possible answer 3:"
                        englishans3 = gets.chomp
                        puts "Enter possible answer 4:"
                        englishans4 = gets.chomp
                        puts "Out of the four answers which were provided, please advise the correct answer:"
                        engcorrectanswer = gets.chomp
                        new_english_quiz_question = EnglishQuizQuestion.new(englishnewquizq, englishans1, englishans2, englishans3, englishans4, engcorrectanswer)
                        new_english_quiz_question.write_to_file_english
                    elsif input_new_quiz_questions == "Science"
                        puts "Enter your new quiz question"
                        sciencenewquizq = gets.chomp
                        puts "Enter possible answer 1:"
                        scienceans1 = gets.chomp
                        puts "Enter possible answer 2:"
                        scienceans2 = gets.chomp
                        puts "Enter possible answer 3:"
                        scienceans3 = gets.chomp
                        puts "Enter possible answer 4:"
                        scienceans4 = gets.chomp
                        puts "Out of the four answers which were provided, please advise the correct answer:"
                        scicorrectanswer = gets.chomp
                        new_science_quiz_question = ScienceQuizQuestion.new(sciencenewquizq, scienceans1, scienceans2, scienceans3, scienceans4, scicorrectanswer)
                        new_science_quiz_question.write_to_file_science
                    elsif input_new_quiz_questions == "History"
                        puts "Enter your new quiz question"
                        historynewquizq = gets.chomp
                        puts "Enter possible answer 1:"
                        historyans1 = gets.chomp
                        puts "Enter possible answer 2:"
                        historyans2 = gets.chomp
                        puts "Enter possible answer 3:"
                        historyans3 = gets.chomp
                        puts "Enter possible answer 4:"
                        historyans4 = gets.chomp
                        puts "Out of the four answers which were provided, please advise the correct answer:"
                        histcorrectanswer = gets.chomp
                        new_history_quiz_question = HistoryQuizQuestion.new(historynewquizq, historyans1, historyans2, historyans3, historyans4, histcorrectanswer)
                        new_history_quiz_question.write_to_file_history
                    end
                    puts Rainbow("Your question has now been added to the list!").yellow
            else superuser_menu == 'Exit Program'
                puts "Thank you for using the Quiz Bites app!"
                exit
            end
        end
    elsif list_of_users[0][:accesslevel] != "Facilitator"
    # Menu for student
    loop do
    student_menu = prompt.select("Please select what subject you would like to be quizzed on from the following options:") do |studentmenu|
        studentmenu.choice 'English'
        studentmenu.choice 'Science'
        studentmenu.choice 'History'
        studentmenu.choice 'Exit Program'
        end
        end
    end
else 
    puts Rainbow("Invalid Username and/or Password").red
end
    
