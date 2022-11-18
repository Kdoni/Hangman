require 'json'

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
    puts "You've got #{@@attempts} attempts to do so.\n\n"
    puts "Anytime, try pressing 'save' to save your current progress or 'load' to start load your recent save file.\n\n"
    play_game
  end

  private_class_method def self.play_game
    while @@game_over == false
      puts @@unknown.join('')
      @@guess = gets.chomp
      begin
        if @@guess == 'load'
          load_game
          break
        end
      rescue StandardError
        puts 'Try playing the game first...bro...'
        next
      end
      if @@guess == 'save'
        save
        puts 'Saved Game'
        next
      end
      next if check_invalid_guesses
      next if repeated_word

      check_guess
    end
  end

  private_class_method def self.check_invalid_guesses
    if @@alphabet.include?(@@guess.downcase) == false || @@guess == ''
      puts 'invalid input, try again...'
      true
    end
  end

  private_class_method def self.repeated_word
    if @@discarded_letter_array.include?(@@guess.downcase) || @@accepted_letters_array.include?(@@guess.downcase)
      puts 'repetion...'
      true
    end
  end

  private_class_method def self.winning_condition
    if @@unknown.include?('-') == false
      @@game_over = true
      puts "Congratulations, you've found the word #{@@unknown.join('').upcase}, you've won!"
    end
  end

  private_class_method def self.game_is_over
    if @@attempts == 0
      puts "You've lost. The hidden word was #{@@target.join('').upcase}. Game Over..."
      @@game_over = true
    end
  end

  private_class_method def self.save
    hash = {
      target: @@target,
      attempts: @@attempts,
      unknown: @@unknown,
      discarded: @@discarded_letter_array,
      accepted: @@accepted_letters_array
    }
    save_file(hash.to_json)
  end

  private_class_method def self.save_file(text)
    file = File.open('save_file', 'w')
    file.write(text)
    file.close
  end

  private_class_method def self.load_game
    file = File.open('save_file', 'r')
    hash = JSON.load(file.read)
    @@target = hash['target']
    @@attempts = hash['attempts']
    @@unknown = hash['unknown']
    @@discarded_letter_array = hash['discarded']
    @@accepted_letters_array = hash['accepted']
    play_game
  end

  private_class_method def self.check_guess
    if @@target.include?(@@guess.downcase) && @@alphabet.include?(@@guess)
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
    winning_condition
  end
end
Hangman.start_game
