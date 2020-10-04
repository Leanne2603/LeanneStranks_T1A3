# To capture when the file can not be located in the specified path
def file_not_found(filetype)
    pastel = Pastel.new
    font = TTY::Font.new
    if filetype == "json"
        # QB01 error: JSON file can not be located in specified path
        puts pastel.red(font.write("ERROR!"))
        puts Rainbow("****** There is an error with loading the program, please contact your administrator! ******").yellow
        puts "Error: QB01"
        logout()
    elsif filetype == "csv view existing"
        puts pastel.red(font.write("ERROR!")) 
        puts Rainbow("An error has occurred whilst trying to execute your request.").yellow
        puts Rainbow("The file you are trying to access is not available.").yellow
        puts Rainbow("Please contact your administrator").yellow
    else
        puts pastel.red(font.write("ERROR!"))
        puts Rainbow("****** There is an error with loading the program, please contact your administrator! ******").yellow 
        logout()
    end
end