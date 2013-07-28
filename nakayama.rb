#!/usr/bin/env ruby
# -*- mode:ruby; coding:utf-8 -*-

def count_cattleheads(cards)
  heads = 0
  cards.each{|card|
    if card == 55 then heads += 7
    elsif card % 11 == 0 then heads += 5
    elsif card % 10 == 0 then heads += 3
    elsif card % 5 == 0 then heads += 2
    else heads += 1
    end
  }
  return heads
end

def solve(hand, rows)
  card = hand.sample
  hand.delete(card)
  return card
end

def select(rows)
  heads_of_rows = rows.map{|row| count_cattleheads(row)}
  debug(heads_of_rows, "heads_of_rows")
  idx = heads_of_rows.index(heads_of_rows.min)
  debug(idx, "idx")
  return idx
end

def main(args)
  n = -1
  names = []
  hand = []
  while true do
    data = gets.strip().split()
    debug(data, "data")
    status = data[0]
    if status == "players"
      n = data[1].to_i
      data.shift(2)
      names = data
      debug(names,"names")
      print
      $stdout.flush
    elsif status == "cards"
      num_cards = data[1].to_i
      hand = data[2].split(",").map{|x| x.to_i}.sort
      print
      $stdout.flush
      debug(hand, "hand")
      break
    end
  end
  
  if n != names.size then
    $stderr.puts("Error: incorrect number of players.ruby")
  end
  if hand.size != 10 then
    $stderr.puts("Error: incorrect number of cards in hand.ruby")
  end
  
  while true do
    data = gets.strip().split()
    debug(data, "data")
    status = data[0]
    if status == "rows"
      rows = []
      data.shift(1)
      debug(data,"data")
      data.each{|row|
       rows.push(row.split(",").map{|x| x.to_i})
      }
      # debug(rows,"rows")
      puts solve(hand, rows)
    elsif status == "places"
      places = []
      data.shift(1)
      data.each{|row|
       places.push(row.split(",").map{|x| x.to_i})
      }
      puts
    elsif status == "info"
      rows = []
      data.shift(1)
      data[1..4].each{|row|
       rows.push(row.split(",").map{|x| x.to_i})
      }
      debug(rows, "rows")
      opp = data[5].to_i
      opp_card = data[6].to_i
      opp_idx = data[7].to_i
      if data.size == 9
        opp_row = data[8].split(",").map{|x| x.to_i}
        debug(opp_row, "opp_row")
      end
      puts
    elsif status == "select"
      rows = []
      data.shift(1)
      data.each{|row|
       rows.push(row.split(",").map{|x| x.to_i})
      }
      debug(rows, "rows")
      puts select(rows)
    elsif status == "quit"
      puts
      break
    end
    $stdout.flush
  end
end

def debug(arg, name)
  $stderr.puts "#{name} is.."
  $stderr.print arg
  $stderr.puts
end
    
if __FILE__ == $0 then
  main(ARGV)
end
