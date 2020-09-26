class NewUser
    attr_reader :fullname, :username, :password, :superuser
    def initialize(fullname, username, password)
        @fullname = fullname
        @username = username
        @password = password
        @superuser = superuser
    end

end

# class Superuser < User
# end

# class Student < User
# end