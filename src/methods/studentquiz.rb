# runs the quiz for the student user
def run_quiz(subject)
    begin
    pastel = Pastel.new
    font = TTY::Font.new

    if subject == "English"
        quizlist = CSV.read("csv/english_quiz_questions.csv")
    elsif subject == "Science"
        quizlist = CSV.read("csv/science_quiz_questions.csv")
    else
        quizlist = CSV.read("csv/history_quiz_questions.csv")
    end

    index = 0
    score = 0
    answer = ""
    while index < 10 do
        puts "Choose which is correct from the following options or type exit to leave the program:"
        quiz_question = quizlist.sample
        output_question = quiz_question.values_at(0..4)
        puts output_question
        answer = gets.chomp
        index += 1

        if  answer == quiz_question[-1]
            score += 1
        elsif answer == "exit".downcase
            puts pastel.cyan(font.write("Thank you!"))                        
            exit
        end

    end
    system("clear")
    result = case score
    when 0..3 then puts Rainbow("Your score was #{score}/10. There is room for improvement").pink
    when 4..7 then puts Rainbow("Your score was #{score}/10. Well done").pink
    when 8..10 then puts Rainbow("Your score was #{score}/10. Amazing work!").pink
    end
rescue
    puts Rainbow("An error has occured, please try again or contact your facilitator").red
end
end