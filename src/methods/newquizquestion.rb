def createnewquestion(subject)
    puts "Enter your new quiz question"
    question = gets.chomp.gsub(/,/, ";")
    puts "Enter possible answer 1:"
    answer1 = gets.chomp.gsub(/,/, ";")
    puts "Enter possible answer 2:"
    answer2 = gets.chomp.gsub(/,/, ";")
    puts "Enter possible answer 3:"
    answer3 = gets.chomp.gsub(/,/, ";")
    puts "Enter possible answer 4:"
    answer4 = gets.chomp.gsub(/,/, ";")
    puts "Out of the four answers which were provided, please advise the correct answer:"
    correctanswer = gets.chomp.gsub(/,/, ";")

    if subject == "English"
        File.write("csv/english_quiz_questions.csv", "#{question},#{answer1},#{answer2},#{answer3},#{answer4},#{correctanswer}\n", mode: "a")
    elsif subject == "Science"
        File.write("csv/science_quiz_questions.csv", "#{question},#{answer1},#{answer2},#{answer3},#{answer4},#{correctanswer}\n", mode: "a")
    else 
        File.write("csv/history_quiz_questions.csv", "#{question},#{answer1},#{answer2},#{answer3},#{answer4},#{correctanswer}\n", mode: "a")
    end
    system("clear")
    puts Rainbow("Your question has now been added to #{subject} quiz list!").yellow
end