require 'pry'

def get_user_name
  username = ''
  is_invalid = true
  while is_invalid do
    puts "Enter your name:"
    username = gets.chomp

    if username.to_i != 0 || username == '0'
      username = get_user_name
    end

    if username.class == String && username.length > 0
      is_invalid = false
    end
  end
  username
end

# binding.pry
