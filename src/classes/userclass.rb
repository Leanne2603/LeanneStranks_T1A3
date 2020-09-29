require 'tty-font'
require 'rainbow'

class NewQuizAppUser
    attr_accessor :fullname, :username, :password, :accesslevel
    def initialize(username,password)
        @fullname = fullname
        @username = username
        @password = password
        @accesslevel = accesslevel
    end

end

