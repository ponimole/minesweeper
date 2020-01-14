require 'io/console'

# Reads keypresses from the user including 2 and 3 escape character sequences.
def read_char
  STDIN.echo = false
  STDIN.raw!

  input = STDIN.getc.chr
  if input == "\e" then
    input << STDIN.read_nonblock(3) rescue nil
    input << STDIN.read_nonblock(2) rescue nil
  end
ensure
  STDIN.echo = true
  STDIN.cooked!

  return input
end

# oringal case statement from:
# http://www.alecjacobson.com/weblog/?p=75
def update_pos
  c = read_char

  case c
#   when " "
#     puts "SPACE"
#   when "\t"
#     puts "TAB"
  when "\r"
    puts "RETURN"
    return "ENTER"
#   when "\n"
#     puts "LINE FEED"
#   when "\e"
#     puts "ESCAPE"
  when "\e[A"
    # puts "UP ARROW"
    return "UP"
  when "\e[B"
    # puts "DOWN ARROW"
    return "DOWN"
  when "\e[C"
    # puts "RIGHT ARROW"
    return "RIGHT"
  when "\e[D"
    # puts "LEFT ARROW"
    return "LEFT"
#   when "\177"
#     puts "BACKSPACE"
#   when "\004"
#     puts "DELETE"
#   when "\e[3~"
#     puts "ALTERNATE DELETE"
  when "f" || "F"
    return "F"
  when "s" || "S"
    return "S"
  when "\u0003"
    puts "CONTROL-C"
    exit 0
  when /^.$/
    puts "SINGLE CHAR HIT: #{c.inspect}"
  else
    puts "SOMETHING ELSE: #{c.inspect}"
  end
end

# update_pos 
# while(true)