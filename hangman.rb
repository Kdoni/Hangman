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
  @@target = accepted.sample
  @@attempts = 10
  @@unknown = Array.new(@@target.length, '-')
  @@alphabet = 'abcdefghijklmnopqrstuvwxyz'
  @@discarded_letter_array = []

  def self.start_game
    puts "\nWelcome to a game of Hangman! Ready for a challenge?\n\n"
    puts "Try finding the hidden word.\n\n"
    puts @@unknown.join('')
    puts "You've got #{@@attempts} attempts to do so."
    play_game
  end

  def self.check_guess
    while @@game_over == false && @@attempts > 0
      if @@guess.length != 1 || !@@alphabet.split('').include?(@@guess.downcase)
        puts "invalid input, try another letter\n"
        play_game
      else
        @@attempts -= 1
        game_progress
      end
    end
  end

  def self.discard_letter
    if @@alphabet.include?(@@guess.downcase) == false && @@discarded_letter_array.include?(@@guess.downcase) == false
      @@discarded_letter_array.push(@@guess)
    end
  end

  def self.game_progress
    if @@target.split('').include?(@@guess)
      puts 'true'
    else
      puts 'false'
    end
  end

  def self.play_game
    puts 'Choose a letter.'
    @@guess = gets.chomp
    check_guess
  end
end
Hangman.start_game
