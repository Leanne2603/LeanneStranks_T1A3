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

    puts Rainbow("Your details have been added to Quizbites").magenta
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
end

def login
    prompt = TTY::Prompt.new
    userpassword = false
    until userpassword
        puts "Please enter your username or type exit to leave the program:"
        input_username = gets.chomp.capitalize.strip
        if input_username == "Exit"
            logout()
        end
        input_password = prompt.mask("Please enter your password:").strip
        list_of_users = JSON.parse(File.read("json/users.json"), symbolize_names: true)
        user = list_of_users.find { |user| user[:username] == input_username}
            system("clear")
            if user[:accesslevel] == "Facilitator" && user[:password] == input_password
                userpassword = true
                return "Facilitator"
            elsif user[:accesslevel] == "Student" && user[:password] == input_password
                userpassword
                return "Student"
            else
                puts Rainbow("Your password is invalid, please try again").red
            end
    end
end

def logout
    pastel = Pastel.new
    font = TTY::Font.new
    puts pastel.cyan(font.write("Thank you!"))  
    exit  
end