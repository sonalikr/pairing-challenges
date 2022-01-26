class Oystercard

  attr_reader :balance
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  JOURNEY_PRICE = 5
  attr_reader :entry_station
  attr_reader :journeys


  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    fail "Maximum balance reached" if @balance >= MAX_BALANCE
    @balance += amount
    "#{@balance} added to account"
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(station)
    @entry_station = station
  end

  def touch_out(exitstation)
    journeys.push({"in" => @entry_station, "out" => exitstation})
    @entry_station = nil
    deduct(JOURNEY_PRICE)
  end

  private

  def deduct(amount)
    fail "No minimum balance" if @balance <= MIN_BALANCE
    @balance -= amount
    "#{amount} deducted from account"
  end
  
end

