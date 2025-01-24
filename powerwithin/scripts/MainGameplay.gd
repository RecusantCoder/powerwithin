extends Node

@onready var ui = preload("res://scenes/GameUI.tscn").instantiate()

var card_loader: CardLoader
var deck_manager: DeckManager
var current_energy: int = 3
var turn_number: int = 1  # To track the game turn

func _ready():
	add_child(ui)  # Add the UI to the scene
	# Connect the signal from GameUI to MainGameplay
	ui.card_played.connect(self._on_card_played)
	# Initialize the card loader and deck manager
	card_loader = CardLoader.new()
	card_loader.load_cards()
	deck_manager = DeckManager.new()
	deck_manager.initialize_deck(card_loader)

	print("Game initialized.")
	print("Starting turn", turn_number)
	start_player_turn()

# Player's turn begins
func start_player_turn():
	current_energy = 3
	print("New turn begins! Energy reset to", current_energy)
	deck_manager.draw_cards(deck_manager.max_hand_size)
	ui.update_ui(current_energy, deck_manager.deck.size(), deck_manager.discard_pile.size(), deck_manager.hand)
	print("Your hand:", deck_manager.get_deck_names())

# Play a card
func play_card(card_index: int):
	if card_index < 0 or card_index >= deck_manager.hand.size():
		print("Invalid card index.")
		return

	var card = deck_manager.hand[card_index]
	if current_energy >= card.cost:
		current_energy -= card.cost
		deck_manager.play_card(card_index)
		ui.update_ui(current_energy, deck_manager.deck.size(), deck_manager.discard_pile.size(), deck_manager.hand)
		print("Played card:", card.name)
	else:
		print("Not enough energy to play:", card.name)
	print("Remaining energy:", current_energy)

# End the player's turn
func end_turn():
	print("Ending turn", turn_number, ". Discarding unused cards...")
	for card in deck_manager.hand:
		deck_manager.discard_pile.append(card)
	deck_manager.hand.clear()
	ui.update_ui(current_energy, deck_manager.deck.size(), deck_manager.discard_pile.size(), [])

	# Simulate the enemy turn
	simulate_enemy_turn()

	# Proceed to the next turn
	turn_number += 1
	print("Turn", turn_number, "starting...")
	start_player_turn()

# Simulates an enemy turn
func simulate_enemy_turn():
	print("Enemy's turn begins...")
	# Placeholder logic for enemy actions (can be replaced later with proper enemy AI)
	var enemy_damage = randi() % 5 + 1  # Random damage between 1 and 5
	print("Enemy deals", enemy_damage, "damage to you!")
	# Add additional enemy logic as needed
	print("Enemy's turn ends.")
	


func _on_card_played(card_index):
	play_card(card_index)
