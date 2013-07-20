#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""6 nimmt! solver"""

import sys, random

# count cattle heads in cards
def count_cattleheads(cards):
	heads = 0
	for card in cards:
		if card == 55: heads += 7
		elif card % 11 == 0: heads += 5
		elif card % 10 == 0: heads += 3
		elif card % 5 == 0: heads += 2
		else: heads += 1
	return heads

# choose a card in hand
def solve(hand, rows):
	card = random.choice(hand)
	hand.remove(card)
	return card

# select a row of cards to take
def select(rows):
	return random.randint(0, len(rows) - 1)

def main(args):
	N = -1
	names = []
	hand = []
	while True:
		data = sys.stdin.readline().strip().split()
		status = data[0]
		if status == "players":
			N = int(data[1])
			names = data[2:]
			print
			sys.stdout.flush()
		elif status == "cards":
			num_cards = int(data[1])
			hand = sorted(map(int, data[2].split(",")))
			print
			sys.stdout.flush()
			break

	if N != len(names):
		print >>sys.stderr, "Error: incorrect number of players."
	if len(hand) != 10:
		print >>sys.stderr, "Error: incorrect number of cards in hand."

	while True:
		data = sys.stdin.readline().strip().split()
		status = data[0]
		if status == "rows":
			rows = [map(int, d.split(",")) for d in data[1:]]
			# send card from the hand via standard output
			print solve(hand, rows)
		elif status == "places":
			# placed cards of each players
			places = [map(int, d.split(" ")) for d in data[1:]]
			print
		elif status == "info":
			rows = [map(int, d.split(",")) for d in data[1:5]]
			opp = int(data[5])       # player index
			opp_card = int(data[6])  # placed card by player
			opp_idx = int(data[7])   # index of selected row by player
			if len(data) == 9:
				opp_row = map(int, data[8].split(","))  # taken cards by player
			print
		elif status == "select":
			rows = [map(int, d.split(",")) for d in data[1:]]
			# send index of selected row via standard output
			print select(rows)
		elif status == "quit":
			print
			break
		sys.stdout.flush()

if __name__ == "__main__": main(sys.argv)
