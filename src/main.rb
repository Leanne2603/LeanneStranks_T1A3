require 'rainbow'
require 'csv'
require 'json'
require 'tty-prompt'
require_relative 'userclass'
prompt = TTY::Prompt.new


# Login authentication
puts "Welcome to Quiz Bites!"
puts "Please enter your username:"
input_username = gets.chomp
input_password = prompt.mask("Please enter your password:")
list_of_users = JSON.parse(File.read("src/users.json"), symbolize_names: true)
if list_of_users[0][:password] == input_password && list_of_users[0][:issuperuser] == true
    loop do
        # Menu for super user
    prompt.select("Please select what you would like to do from the following options:", %w(Create_New_User View_Existing_Users Create_New_Questions View_Existing_Quizzes Exit_Program))
    end
elsif list_of_users[0][:password] == input_password && list_of_users[0][:issuperuser] != true
        # Menu for student
    loop do
    prompt.select("Please select what you would like to be quizzed on from the following options:", %w(English Science History Exit_Program))
    end
else 
    puts "Invalid Password"
end
    




