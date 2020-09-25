class User
    attr_reader :username
    def initialize(fullname, username, password)
        @fullname = fullname
        @username = username
        @password = password
    end

end

class Superuser < User
end

class Student < User
end