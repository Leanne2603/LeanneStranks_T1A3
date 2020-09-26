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