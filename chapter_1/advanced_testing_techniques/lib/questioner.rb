# frozen_string_literal: true

class Questioner
  def initialize(input=STDIN, output=STDOUT)
    @input = input
    @output = output
  end

  def inquire_about_happiness
    ask('Are you happy?') ? "Good I'm Glad" : "That's Too Bad"
  end

  def ask(question)
    @output.puts question
    response = @input.gets.chomp
    case(response)
    when /^y(es)?$/i
      true
    when /^no?$/i
      false
    else
      @output.puts "I don't understand."
    end
  end
end

