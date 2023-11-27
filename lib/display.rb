class Display
  def exit_or_proceed(input)
    input == 'exit' ? exit(true) : input
  end

  def draw(screen)
    puts '---------------------------------'
    puts screen
    puts '---------------------------------'
  end

  def print(message)
    puts message
  end

  def get_input_to_int
    input = exit_or_proceed(gets.chomp)
    input.scan(/\D/).any? ? input : input.to_i
  end

  def get_input_to_sym
    exit_or_proceed(gets.chomp).to_sym
  end

  def get_input_as_str
    exit_or_proceed(gets.chomp)
  end
end
