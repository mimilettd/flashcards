require './lib/card'
require './lib/guess'
require './lib/deck'
require './lib/round'
require './lib/card_generator'

class FlashcardRunner
  attr_reader :deck

  def initialize
    get_filepath
  end

  def get_filepath
    if ARGV.empty?
      puts "Please enter a filename"
      filename = gets.chomp
    else
      filename = ARGV[0]
    end
    validate_filepath(filename)
  end

  def validate_filepath(filename)
    if File.exist?(filename)
      load_deck(filename)
    else
      puts "File does not exist. Please enter a new filename"
      filename = gets.chomp
      validate_filepath(filename)
    end
  end

  def load_deck(filename)
    cards = CardGenerator.new(filename).cards
    @deck = Deck.new(cards)
    new_round
  end

  def new_round
    puts "Welcome! You're playing with #{@deck.count} cards."
    puts "-------------------------------------------------"
    round = Round.new(@deck)
    round.start
  end
end

FlashcardRunner.new
