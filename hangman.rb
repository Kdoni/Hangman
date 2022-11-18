def accepted
  dictionary = File.read('words.txt')
  acceptable_words = []

  test = dictionary.split("\n")
  test.each do |word|
    acceptable_words.push(word) if word.length > 4 && word.length < 13
  end
  acceptable_words
end

class Hangman
  @@game_over = false
  @@guess = ''
  @@target = accepted.sample.split('')
  @@attempts = 5
  @@unknown = Array.new(@@target.length, '-')
  @@alphabet = 'abcdefghijklmnopqrstuvwxyz'
  @@discarded_letter_array = []
  @@accepted_letters_array = []

  def self.start_game
    puts "\nWelcome to a game of Hangman! Ready for a challenge?\n\n"
    puts "Try finding the hidden word.\n\n"
    puts "You've got #{@@attempts} attempts to do so."
    p @@target
    play_game
  end

  def self.play_game
    while @@game_over == false
      puts @@unknown.join('')
      @@guess = gets.chomp
      winning_condition
      check_invalid_guesses
      repeated_word
      check_guess
    end
  end

  def self.check_invalid_guesses
    while @@alphabet.include?(@@guess.downcase) == false
      puts 'invalid input, try again...'
      play_game
    end
  end

  def self.repeated_word
    while @@discarded_letter_array.include?(@@guess.downcase) || @@accepted_letters_array.include?(@@guess.downcase) && @@game_over == false
      puts 'repetion...'
      play_game
    end
  end

  def self.winning_condition
    if @@unknown.include?('-') == false
      @@game_over = true
      puts "Congratulations, you've found the word #{@@unknown.join('').capitalize}, you've won!"
    end
  end

  def self.game_is_over
    if @@attempts == 0
      puts "You've lost. Game Over..."
      @@game_over = true
    end
  end

  def self.check_guess
    if @@target.include?(@@guess.downcase)
      @@accepted_letters_array.push(@@guess)
      @@target.each_with_index do |v, i|
        @@unknown[i] = v if v == @@guess.downcase
      end
    else
      puts 'Incorrect word...'
      @@discarded_letter_array.push(@@guess)
      @@attempts -= 1
      puts "you've got #{@@attempts} attempts left... : Your discarded letters' pile: #{@@discarded_letter_array}"
      game_is_over
    end
  end
end
Hangman.start_game
