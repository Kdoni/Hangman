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
  @@guess = ''
  @@target = accepted.sample
  @@attempts = 10
  @@unknown = Array.new(@@target.length, '-')
  @@alphabet = 'abcdefghijklmnopqrstuvwxyz'

  def self.start_game
    puts "\nWelcome to a game of Hangman! Ready for a challenge?\n\n"
    puts "Try finding the hidden word.\n\n"
    puts @@unknown.join('')
    puts "You've got #{@@attempts} attempts to do so."
    play_game
  end

  def self.check_guess
    if @@guess.length != 1 || @@alphabet.split('').include?(@@guess) == false
      puts 'invalid input...'
    else
      puts 'valid input'
    end
  end

  def self.play_game
    puts 'Choose a letter.'
    @@guess = gets.chomp
    check_guess
  end
end
Hangman.start_game
