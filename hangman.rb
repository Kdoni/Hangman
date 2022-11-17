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
  @@attempts = 10
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
    end
  end

  def self.check_guess
    if @@target.include?(@@guess)
      puts 'good'
    else
      puts 'bad'
    end
  end
end
Hangman.start_game
