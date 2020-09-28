# require_relative 'quizquestionsclass'
# require 'tty-prompt'
# require 'tty-font'
# prompt = TTY::Prompt.new
# font = TTY::Font.new
# pastel = Pastel.new


# class Superuser
#     def self.superusermenu
#         loop do
#             # Menu for super user
#         superuser_menu = prompt.select("Please select what you would like to do from the following options:") do |superusermenu|
#             superusermenu.choice 'Create New User'
#             superusermenu.choice 'View Existing Users'
#             superusermenu.choice 'Create New Questions'
#             superusermenu.choice 'View Existing Quizzes'
#             superusermenu.choice 'Exit Program'
#             end
#             if superuser_menu == "Create New User"
#                 puts "What is the new user's full name?"
#                 input_new_user = gets.chomp
#                 puts "What username would you like to assign to this user?"
#                 input_new_username = gets.chomp
#                 puts "Assign a password for this user:"
#                 input_new_password = gets.chomp
#                 input_is_newuser_superuser = prompt.select("Is this new user a Facilitator or Student?") do |accesslevel|
#                 accesslevel.choice 'Facilitator'
#                 accesslevel.choice 'Student' 
#                 # Need to be able to write to file!    
#                 end
#             elsif superuser_menu == "View Existing Users"
#                 puts Rainbow("The following is a list of the current users:").cyan
#                 list_of_users.each do |details|
#                     puts Rainbow("Fullname: #{details[:fullname].ljust(40, ".")} Username: #{details[:username].ljust(35, ".")} Password: #{details[:password].ljust(30, ".")} Access Level: #{details[:accesslevel]}").blue
#                 end
#             elsif superuser_menu == "Create New Questions"
#                 input_new_quiz_questions = prompt.select("Please select which subject you wish to add to:") do |newq|
#                     newq.choice 'English'
#                     newq.choice 'Science'
#                     newq.choice 'History'
#                 end
#                 puts "In the next steps, you will be asked to enter your quiz question followed by 4 possible answers. You will then be asked to advise which is the correct answer"
#                 if input_new_quiz_questions == "English"
#                     new_english_quiz_question = EnglishQuizQuestion.createnewquestion("English")
#                 elsif input_new_quiz_questions == "Science"
#                     new_science_quiz_question = NewQuizQuestion.createnewquestion("Science")
#                 elsif input_new_quiz_questions == "History"
#                     new_history_quiz_question = NewQuizQuestion.createnewquestion("History")
#                 end
#             elsif superuser_menu == "View Existing Quizzes"
#                 existing_quizzes = prompt.select("Select which subject you would like to view from the following:") do |view|
#                     view.choice 'English'
#                     view.choice 'Science'
#                     view.choice 'History'
#                 end
#                     if existing_quizzes == "English"
#                         CSV.foreach("english_quiz_questions.csv", headers: true) { |row| puts "QUESTION: #{row['question']} A: #{row['answer1']} B: #{row['answer2']} C: #{row['answer3']} D: #{row['answer4']} CORRECT ANSWER: #{row['correctanswer']}" }
#                     elsif existing_quizzes == "Science"
#                         CSV.foreach("science_quiz_questions.csv", headers: true) { |row| puts "QUESTION: #{row['question']} A: #{row['answer1']} B: #{row['answer2']} C: #{row['answer3']} D: #{row['answer4']} CORRECT ANSWER: #{row['correctanswer']}" }
#                     elsif existing_quizzes == "History"
#                         CSV.foreach("history_quiz_questions.csv", headers: true) { |row| puts "QUESTION: #{row['question']} A: #{row['answer1']} B: #{row['answer2']} C: #{row['answer3']} D: #{row['answer4']} CORRECT ANSWER: #{row['correctanswer']}" }
#                     end
#             else superuser_menu == 'Exit Program'
#                 puts pastel.cyan(font.write("Thank you!"))
#                 exit
#             end
#         end
#     end
# end