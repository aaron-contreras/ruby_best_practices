# frozen_string_literal: true

class Questioner
  def ask(question)
    puts question
    respoonse = gets.chomp
    case(response)
    when /^y(es)?$/i
      true
    when /^no?$/i
      false
    else
      puts "I don't understand."
      ask question
    end
  end
end

