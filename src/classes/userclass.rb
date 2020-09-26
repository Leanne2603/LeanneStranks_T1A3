class QuizAppUser
    attr_reader :fullname, :username, :password, :accesslevel
    def initialize(username,password)
        @username = username
        @password = password
    end
end