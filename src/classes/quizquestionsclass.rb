class NewQuizQuestion
    attr_accessor :question, :answer1, :answer2, :answer3, :answer4, :correctanswer
    def initialize(question, answer1, answer2, answer3, answer4, correctanswer)
        @question = question
        @answer1 = answer1
        @answer2 = answer2
        @answer3 = answer3
        @answer4 = answer4
        @correctanswer = correctanswer
    end

    def self.createnewquestion(subject)
        puts "Enter your new quiz question"
        @question = gets.chomp
        puts "Enter possible answer 1:"
        @answer1 = gets.chomp
        puts "Enter possible answer 2:"
        @answer2 = gets.chomp
        puts "Enter possible answer 3:"
        @answer3 = gets.chomp
        puts "Enter possible answer 4:"
        @answer4 = gets.chomp
        puts "Out of the four answers which were provided, please advise the correct answer:"
        @correctanswer = gets.chomp

        new_english_quiz_question = EnglishQuizQuestion.new(@question, @answer1, @answer2, @answer3, @answer4, @correctanswer)
        new_english_quiz_question.write_to_file_english
        
        new_science_quiz_question = ScienceQuizQuestion.new(@question, @answer1, @answer2, @answer3, @answer4, @correctanswer)
        new_science_quiz_question.write_to_file_science

        new_history_quiz_question = HistoryQuizQuestion.new(@question, @answer1, @answer2, @answer3, @answer4, @correctanswer)
        new_history_quiz_question.write_to_file_history
    end
end

class EnglishQuizQuestion < NewQuizQuestion
    
    def write_to_file_english
        File.write("english_quiz_questions.csv", "#{question},#{answer1},#{answer2},#{answer3},#{answer4},#{correctanswer}\n", mode: "a")
    end
end

class ScienceQuizQuestion < NewQuizQuestion
    def write_to_file_science
        File.write("science_quiz_questions.csv", "#{question},#{answer1},#{answer2},#{answer3},#{answer4},#{correctanswer}\n", mode: "a")
    end
end

class HistoryQuizQuestion < NewQuizQuestion
    def write_to_file_history
        File.write("history_quiz_questions.csv", "#{question},#{answer1},#{answer2},#{answer3},#{answer4},#{correctanswer}\n", mode: "a")
    end
end