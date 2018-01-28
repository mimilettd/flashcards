class Guess
  attr_reader :response,
              :card,
              :feedback
  def initialize(response, card)
    @response = response
    @card = card
    correct?
  end

  def correct?
    if @response == card.answer
      @feedback = "Correct!"
    else
      @feedback = "Incorrect."
      return false
    end
  end
end
