require 'oystercard'

describe Oystercard do

  let(:station){ double :station } 
  let(:exitstation){ double :station }
  card = Oystercard.new
  it {is_expected.to respond_to :balance}

  it 'has initial balance and journeys' do
    card = Oystercard.new

    expect(card.balance).to eq 0
    expect(card.journeys).to eq []
  end

  it 'can top-up balance' do
    card = Oystercard.new
    expect(card.top_up(20)).to eq "20 added to account"
  end

  it 'has a maximum balance of £90' do
    card = Oystercard.new
    # initial deposit
    card.top_up(90)
    # second deposit

    expect{card.top_up(20)}.to raise_error "Maximum balance reached"
  end

  it 'can touch out' do
    card = Oystercard.new
    card.top_up(60)

    expect(card.touch_out(exitstation)).to eq "5 deducted from account"
    expect(card.entry_station).to eq nil
  end

  it 'can check the customer is on a journey' do
    card = Oystercard.new
    card.touch_in(station)

    expect(card.in_journey?).to eq true
  end
  
  it 'can check the customer is not on a journey' do
    card = Oystercard.new

    expect(card.in_journey?).to eq false
  end

  it 'can touch a user out' do
    card = Oystercard.new
    card.top_up(60)

    expect(card.touch_out(exitstation)).to eq "5 deducted from account"
  end

  it 'has a minimum balance of £1' do
    card = Oystercard.new
    
    expect{card.touch_out(exitstation)}.to raise_error "No minimum balance"
  end

  it 'can deduct money on touch out' do
    card = Oystercard.new
    card.top_up(20)

    expect {card.touch_out(exitstation)}.to change{card.balance}.by(-5)
    
  end

  it 'can save the start location while touch in' do
    card = Oystercard.new
    card.touch_in(station)

    expect(card.entry_station). to eq station
  end

  it 'can save journey on touch out' do
    card = Oystercard.new
    card.top_up(20)
    card.touch_in(station)

    card.touch_out(exitstation)

    expect(card.journeys).to eq [{"in" => station, "out" => exitstation}]
  end

end