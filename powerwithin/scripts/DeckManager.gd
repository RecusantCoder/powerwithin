extends Node

class_name DeckManager

# Deck-related variables
var deck: Array = []           # Cards available to draw
var hand: Array = []           # Cards currently in the player's hand
var discard_pile: Array = []   # Cards that have been played or discarded

var max_hand_size: int = 5

func _ready():
	randomize()  # Seed the random number generator

# Initialize the deck with cards from the CardLoader
func initialize_deck(card_loader: CardLoader):
	print("Initializing deck with cards...")
	for card in card_loader.cards:
		deck.append(card)
	print("Deck initialized with", deck.size(), "cards.")
	shuffle_deck()

# Shuffle the deck using Godot's built-in shuffle method
	
func shuffle_deck() -> void:
	print("Deck before shuffle:", get_deck_names())
	print("Shuffling the deck...")
	deck.shuffle()
	print("Deck shuffled:", get_deck_names())

# Draw cards into the player's hand
func draw_cards(amount: int) -> void:
	print("Drawing", amount, "cards...")
	for _i in range(amount):
		if deck.size() == 0:  # Check if the deck is empty
			print("Deck is empty. Reshuffling discard pile...")
			reshuffle_discard_pile()
		if deck.size() > 0:  # Ensure the deck still has cards after reshuffling
			var drawn_card = deck.pop_front()
			hand.append(drawn_card)
			print("Drew card:", drawn_card.name)
	print("Current hand: \n\n ", get_hand_names())

# Reshuffle the discard pile back into the deck
func reshuffle_discard_pile() -> void:
	print("Reshuffling discard pile into deck...")
	deck += discard_pile
	discard_pile.clear()
	shuffle_deck()

# Play a card from the hand
func play_card(card_index: int) -> void:
	if card_index >= 0 and card_index < hand.size():
		var card = hand[card_index]
		hand.remove_at(card_index)
		discard_pile.append(card)
		print("Played card:", card.name)
		apply_card_effect(card)

# Apply the effect of a played card
func apply_card_effect(card: Card) -> void:
	print("Applying effect of card:", card.name)
	match card.type:
		"Attack":
			print("Dealing", card.attributes.damage, "damage!")
		"Energy":
			print("Gaining", card.attributes.energyGain, "energy!")
		"Stabilization":
			print("Increasing portal stability by", card.attributes.stabilityGain, "%!")
		"Utility":
			print("Applying utility effect:", card.effect)
			

# Helper function to print card names in the deck
func get_deck_names() -> String:
	var names = []
	for card in deck:
		names.append(card.name)
	# Convert the array into a string with commas separating the card names
	var result = ""
	for i in range(names.size()):
		result += names[i]
		if i < names.size() - 1:
			result += ", "
	return result
	
	# Helper function to print card names in hand
func get_hand_names() -> String:
	var names = []
	for card in hand:
		names.append(card.get_card_info())
	# Convert the array into a string with commas separating the card names
	var result = ""
	for i in range(names.size()):
		result += names[i]
		if i < names.size() - 1:
			result += " "
	return result
