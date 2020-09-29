require 'rainbow'
require 'csv'
require 'json'
require 'tty-prompt'
require 'tty-font'
require_relative 'classes/userclass'
require_relative 'classes/quizquestionsclass'
require_relative 'classes/studentquiz'
prompt = TTY::Prompt.new
font = TTY::Font.new
pastel = Pastel.new

# Login authentication
puts pastel.bright_magenta(font.write("Welcome to Quiz Bites"))
puts Rainbow("A place where you can test your skills and expand your mind with multiple choice quizzes!!").cyan
puts "Please enter your username:"
input_username = gets.chomp.capitalize.strip
input_password = prompt.mask("Please enter your password:").strip
list_of_users = JSON.parse(File.read("json/users.json"), symbolize_names: true)
user = list_of_users.find { |user| user[:username] == input_username}
if user[:password] == input_password
    if user[:accesslevel] == "Facilitator"
        loop do
            # Menu for superuser/facilitator access
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
                input_new_username = gets.chomp.capitalize.strip
                puts "Assign a password for this user:"
                input_new_password = gets.chomp.strip
                input_is_newuser_superuser = prompt.select("Is this new user a Facilitator or Student?") do |accesslevel|
                    accesslevel.choice 'Facilitator'
                    accesslevel.choice 'Student'
                end
                system("clear")
                puts Rainbow("#{input_new_user} has been added to Quizbites").magenta
                puts Rainbow("Username: #{input_new_username}").pink
                puts Rainbow("Password: #{input_new_password}").pink
                newuser = {
                    fullname: input_new_user,
                    username: input_new_username,
                    password: input_new_password,
                    accesslevel: input_is_newuser_superuser
                }
                file = File.open('json/users.json', "r+").read
                array = JSON.parse(file)
                array.push(newuser)
                json = JSON.generate(array)
                File.write('json/users.json', json)
            elsif superuser_menu == "View Existing Users"
                puts Rainbow("The following is a list of the current users:").cyan
                list_of_users.each do |details|
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
                puts pastel.cyan(font.write("Thank you!"))
                exit
            end
        end
    else
    # Menu for student access
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
                exit
            end
        end
    end
else 
    puts Rainbow("Invalid Username and/or Password").red
end

    

