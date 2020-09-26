require 'rainbow'
require 'csv'
require 'json'
require 'tty-prompt'
require_relative 'userclass'
prompt = TTY::Prompt.new


# Login authentication
puts "Welcome to Quiz Bites!"
puts "A place where you can test your skills and expand your mind with multiple choice quizzes"
puts "Please enter your username:"
input_username = gets.chomp
input_password = prompt.mask("Please enter your password:")
list_of_users = JSON.parse(File.read("src/users.json"), symbolize_names: true)
if list_of_users[0][:password] == input_password && list_of_users[0][:issuperuser] == true
    loop do
        # Menu for super user
    superuser_menu = prompt.select("Please select what you would like to do from the following options:") do |superusermenu|
        superusermenu.choice 'Create New User'
        superusermenu.choice 'View Existing Users'
        superusermenu.choice 'Create New Questions'
        superusermenu.choice 'View Existing Quizzes'
        superusermenu.choice 'Exit Program'
        end
        if superuser_menu == 'Create New User'
        end
    end
elsif list_of_users[0][:password] == input_password && list_of_users[0][:issuperuser] != true
        # Menu for student
    loop do
    student_menu = prompt.select("Please select what subject you would like to be quizzed on from the following options:") do |studentmenu|
        studentmenu.choice 'English'
        studentmenu.choice 'Science'
        studentmenu.choice 'History'
        studentmenu.choice 'Exit Program'
        end
    end
else 
    puts "Invalid Password"
end
    





