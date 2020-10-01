def main_menu
    prompt = TTY::Prompt.new
    main_selection = prompt.select("Please select what you would like to do from the following options:", ["Login", "Create New account"])
    return main_selection
end

def create_new_account
    require "json"
    puts "What is your full name?"
    input_new_user = gets.chomp
    puts "Please enter a username:"
    input_new_username = gets.chomp.capitalize.strip
    puts "Please enter a password:"
    input_new_password = gets.chomp.strip
    input_is_newuser_superuser = "Student"
    system("clear")
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
        puts "Please enter your username:"
        input_username = gets.chomp.capitalize.strip
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
                puts "Your password is invalid, please try again"
            end
    end
end