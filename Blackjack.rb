class Deck
  attr_reader :cards
  def initialize
    @cards = (2..10).to_a * 4 + ['J', 'Q', 'K', 'A'] * 4
    @cards.shuffle!
  end
end

class Hand
  attr_accessor :cards
  def initialize
    @cards = []
  end

  def value
    value = 0
    @cards.each do |card|
      if card == 'J' || card == 'Q' || card == 'K'
        value += 10
      elsif card == 'A' && value > 10
        value += 1
      elsif card == 'A' && value <= 10
        value += 11
      else
        value += card
      end
    end
    value
  end

  def add_cards(cards)
    @cards << cards
  end
end

class Player
  attr_accessor :hand
  def initialize
    @hand = Hand.new 
  end
end

class Dealer
  attr_accessor :hand
  def initialize(deck)
    @cards = deck.cards
    @hand = Hand.new
  end

  def deal(person)
    person.hand.add_cards(@cards.pop) 
  end
end

class Blackjack
  def initialize
    @deck = Deck.new
    @dealer = Dealer.new(@deck)
    @player = Player.new
    @game_over = false
  end

  def player_win?
    player_value = @player.hand.value
    dealer_value = @dealer.hand.value
    if player_value == 21 || dealer_value > 21
      show_hands
      puts "Player wins!"
      @game_over = true
    end
  end

  def dealer_win?
    player_value = @player.hand.value
    dealer_value = @dealer.hand.value
    if dealer_value == 21 || player_value > 21
      show_hands
      puts "Dealer wins!"
      @game_over = true
    end
  end

  def determine_winner
    if @player.hand.value > @dealer.hand.value
      puts "Player wins!"
    elsif @player.hand.value < @dealer.hand.value
      puts "Dealer wins!"
    else
      puts "It's a tie!"
    end
    @game_over = true
  end

  def show_hands
    puts "Player's hand: #{@player.hand.value}"
    #puts "Dealer's hand: #{@dealer.hand.value}"
  end

  def player_turn
    show_hands
    puts "Hit again? y/n"
    answer = gets.chomp
    if answer == 'y'
      @dealer.deal(@player)
    elsif answer == 'n'
      @dealer.deal(@dealer) until @dealer.hand.value >= 17
      determine_winner
    else
      puts "Invalid input"
      player_turn
    end
  end

  def dealer_turn
    @dealer.deal(@dealer) if @dealer.hand.value < 17
  end

  def play
    2.times { @dealer.deal(@player) }
    2.times { @dealer.deal(@dealer) }
    loop do
      player_turn
      dealer_turn
      player_win?
      dealer_win?
      break if @game_over
    end
  end
end

Blackjack.new.play