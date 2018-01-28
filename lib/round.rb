class Round
  attr_reader :deck,
              :guesses,
              :current_card,
              :card_count
  def initialize(deck)
    @deck = deck
    @guesses = []
    @card_count = 0
  end

  def current_card
    @deck.cards[@card_count]
  end

  def record_guess(input)
    guess = Guess.new(input, current_card)
    guesses << guess
    @card_count += 1
    guess
  end

  def number_correct
    @guesses.select {|i| i.feedback == "Correct!"}.count
  end

  def percent_correct
    (number_correct.to_f / @guesses.count * 100).to_i
  end

  def start
    while card_count < @deck.count
      puts "This is card number #{@card_count + 1} out of #{@deck.count}."
      puts "Question: #{current_card.question}"
      guess = record_guess($stdin.gets.chomp)
      puts guess.feedback
    end
    over
  end

  def over
    puts "****** Game over! ******"
    puts "You had #{number_correct} correct guesses out of #{@deck.count} for a score of #{percent_correct}%."
    save_results
  end

  def save_results
    current_time = Time.now.strftime("%Y-%d-%m-%H:%M%p")
    f = File.new("./data/results-#{current_time}.txt", 'w+')
    @guesses.each do |guess|
      f.puts("#{guess.card.question},#{guess.card.answer},#{guess.response},#{guess.feedback}")
    end
    f.close
  end
end
