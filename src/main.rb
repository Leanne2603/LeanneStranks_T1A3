require 'rainbow'
require 'colorize'
require 'csv'
require 'json'
require 'tty-prompt'
require 'tty-font'
require_relative 'classes/quizquestionsclass'
require_relative 'methods/studentquiz'
require_relative 'methods/loginaccountmanagement'
prompt = TTY::Prompt.new
font = TTY::Font.new
pastel = Pastel.new

# Login authentication
puts pastel.bright_magenta(font.write("Welcome to Quiz Bites"))
puts Rainbow("A place where you can test your skills and expand your mind with multiple choice quizzes!!").cyan
loop do
main = main_menu()
if main == "Login"
    access = login()
    if access == "Facilitator"
        loop do
            # Menu for superuser/facilitator access
            superuser_menu = prompt.select("Please select what you would like to do from the following options:") do |superusermenu|
                superusermenu.choice 'Create New User'
                superusermenu.choice 'View Existing Users'
                superusermenu.choice 'Create New Questions' 
                superusermenu.choice 'View Existing Quizzes' 
                superusermenu.choice 'Exit Program' 
            end
            # did not use create_new_account method for this as different access is required
            if superuser_menu == "Create New User"
                create_new_account("Superuser")
            elsif superuser_menu == "View Existing Users"
                puts Rainbow("The following is a list of the current users:").cyan
                view_users = JSON.parse(File.read("json/users.json"), symbolize_names: true)
                view_users.each do |details|
                    puts Rainbow("Fullname: #{details[:fullname].ljust(40, ".")} Username: #{details[:username].ljust(35, ".")} Password: #{details[:password].ljust(30, ".")} Access Level: #{details[:accesslevel]}").blue
                end
            elsif superuser_menu == "Create New Questions"
                input_new_quiz_questions = prompt.select("Please select which subject you wish to add to:") do |newq|
                    newq.choice 'English'
                    newq.choice 'Science'
                    newq.choice 'History'
                end
                puts "In the next steps, you will be asked to enter your quiz question followed by 4 possible answers. You will then be asked to advise which is the correct answer"
                if input_new_quiz_questions == "English"
                    new_english_quiz_question = NewQuizQuestion.new()
                    new_english_quiz_question.createnewquestion("English")
                elsif input_new_quiz_questions == "Science"
                    new_science_quiz_question = NewQuizQuestion.new()
                    new_science_quiz_question.createnewquestion("Science")
                else 
                    new_history_quiz_question = NewQuizQuestion.new()
                    new_history_quiz_question.createnewquestion("History")
                end
            elsif superuser_menu == "View Existing Quizzes"
                existing_quizzes = prompt.select("Select which subject you would like to view from the following:") do |view|
                    view.choice 'English'
                    view.choice 'Science'
                    view.choice 'History'
                end
                    if existing_quizzes == "English"
                        CSV.foreach("csv/english_quiz_questions.csv", headers: true) {|row| puts "Question: #{row['question']}\n a: #{row['answer1']}\n b: #{row['answer2']}\n c: #{row['answer3']}\n d: #{row['answer4']}\n Correct Answer: #{row['correctanswer']}"}
                    elsif existing_quizzes == "Science"
                        CSV.foreach("csv/science_quiz_questions.csv", headers: true) {|row| puts "Question: #{row['question']}\n a: #{row['answer1']}\n b: #{row['answer2']}\n c: #{row['answer3']}\n d: #{row['answer4']}\n Correct Answer: #{row['correctanswer']}"}
                    else 
                        CSV.foreach("csv/history_quiz_questions.csv", headers: true) {|row| puts "Question: #{row['question']}\n a: #{row['answer1']}\n b: #{row['answer2']}\n c: #{row['answer3']}\n d: #{row['answer4']}\n Correct Answer: #{row['correctanswer']}"}
                    end
            else
                logout()
            end
        end
        #menu for student access
    else access == "Student"
        loop do
            student_menu = prompt.select("Please select what subject you would like to be quizzed on from the following options:") do |studentmenu|
                studentmenu.choice 'English'
                studentmenu.choice 'Science'
                studentmenu.choice 'History'
                studentmenu.choice 'Exit Program'
                end
                if student_menu == 'English'
                    run_quiz("English")
                elsif student_menu == 'Science'
                    run_quiz("Science")
                elsif student_menu == 'History'
                    run_quiz("History")
                else
                    logout()
                end
            end
    end
else
    new_account = create_new_account("Student")
end
end

    

