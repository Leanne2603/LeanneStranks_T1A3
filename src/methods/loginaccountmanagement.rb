require_relative 'filehandling'

def main_menu
    prompt = TTY::Prompt.new
    pastel = Pastel.new
    font = TTY::Font.new
    main_selection = prompt.select("Please select what you would like to do from the following options:", ["Login", "Create New account", "Exit Program"])
    if main_selection == "Exit Program"
        logout()
    else
        return main_selection
    end
end

def create_new_account(access)
    prompt = TTY::Prompt.new
    require "json"

    if  access == "Superuser"
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
    else
        puts "What is your full name?"
        input_new_user = gets.chomp
        puts "Please enter a username:"
        input_new_username = gets.chomp.capitalize.strip
        puts "Please enter a password:"
        input_new_password = gets.chomp.strip
        input_is_newuser_superuser = "Student"
        system("clear")
    end

    begin
        newuser = {
        fullname: input_new_user,
        username: input_new_username,
        password: input_new_password,
        accesslevel: input_is_newuser_superuser
        }
        check_existing_users = JSON.parse(File.read("json/users.json"), symbolize_names: true)
        found = false
        check_existing_users.each { |user| user[:username]
        if  user[:username] == input_new_username
        found = true
        end
        }

        if found
            system("clear") 
            puts Rainbow("The username you have selected already exists, please try again").red
        return 
            create_new_account("Student")
        end

        puts Rainbow("Your details have been added to Quizbites").magenta
        puts Rainbow("Username: #{input_new_username}").pink
        puts Rainbow("Password: #{input_new_password}").pink

        file = File.open('json/users.json', "r+").read
        array = JSON.parse(file)
        array.push(newuser)
        json = JSON.generate(array)
        File.write('json/users.json', json)
    rescue
    # QB01 error: JSON file can not be located in specified path
    file_not_found("json")
    end
end

def login
    prompt = TTY::Prompt.new
    userpassword = false
    until userpassword
        puts "Please enter your username or type EXIT to leave the program:"
        input_username = gets.chomp.capitalize.strip
        if input_username == "Exit"
            logout()
        elsif input_username == "Create"
            create_new_account("Student")
            puts "Please enter your username:"
            input_username = gets.chomp.capitalize.strip
        end
        
        begin
            list_of_users = JSON.parse(File.read("json/users.json"), symbolize_names: true)
            input_password = prompt.mask("Please enter your password:").strip
        rescue
            file_not_found("json")
        end
        user = list_of_users.find { |user| user[:username] == input_username}

        begin
            if user[:accesslevel] == "Facilitator" && user[:password] == input_password
                userpassword = true
                return "Facilitator"
            elsif user[:accesslevel] == "Student" && user[:password] == input_password
                userpassword
                return "Student"
            else
                puts Rainbow("Your password is invalid, please try again").red
            end
        rescue
            no_username()
        end
    end
end

def logout
    pastel = Pastel.new
    font = TTY::Font.new
    puts pastel.cyan(font.write("Thank you!"))
    exit
end

def no_username
    prompt = TTY::Prompt.new
    font = TTY::Font.new
    pastel = Pastel.new
    puts pastel.bright_red(font.write("OOPS!"))
    choice = prompt.select("You seem to have entered an invalid username, please choose what you would like to do from the following:") do |choose|
        choose.choice 'Try again'
        choose.choice 'Create an account'
        choose.choice 'Exit'
    end
        if choice == 'Try again'
            puts "Please try again"
        elsif choice == "Create an account"
            create_new_account("Student")
        else
            logout()
        end
end