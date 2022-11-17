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
    puts @@unknown.join('')
    puts "You've got #{@@attempts} attempts to do so."
    p @@target
    play_game
  end

  def self.play_game
    while @@game_over == false
      @@guess = gets.chomp
      check_guess
      game_is_over
    end
  end

  def self.game_is_over
    if @@attempts == 0
      puts "You've lost. Game Over..."
      @game_over = true
    end
  end

  def self.check_guess
    if @@target.include?(@@guess)
      @@accepted_letters_array.push(@@guess)
      @@target.each_with_index do |v, i|
        @@unknown[i] = v if v == @@guess
      end
    else
      @@discarded_letter_array.push(@@guess)
      @@attempts -= 1
    end
    p @@unknown
  end
end
Hangman.start_game
