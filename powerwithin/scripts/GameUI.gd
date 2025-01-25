extends Control

signal card_played(card_index)  # Define the signal at the top
signal end_turn_pressed()

@export var end_turn_button: Button

var energy_label: Label
var deck_count_label: Label
var discard_count_label: Label
var hand_container: HBoxContainer

func _ready():
	
	# Connects the button to the signal
	if end_turn_button:
		end_turn_button.pressed.connect(self._on_end_turn_button_pressed)
	else:
		print("End Turn Button no assigned!")
	
	energy_label = $VBoxContainer/LabelEnergy  # Adjust paths to match your scene structure
	deck_count_label = $VBoxContainer/LabelDeckCount
	discard_count_label = $VBoxContainer/LabelDiscardPileCount
	hand_container = $HBoxContainer

func update_ui(energy, deck_count, discard_count, hand):
	energy_label.text = "Energy: " + str(energy)
	deck_count_label.text = "Deck: " + str(deck_count)
	discard_count_label.text = "Discard: " + str(discard_count)
	update_hand(hand)

func update_hand(hand):
	# Clear the hand container
	for child in hand_container.get_children():
		child.queue_free()
	
	# Add cards to the hand UI
	for card_index in range(hand.size()):
		var card = hand[card_index]
		var card_button = Button.new()
		card_button.text = card.name
		card_button.pressed.connect(self._on_card_played.bind(card_index))
		hand_container.add_child(card_button)

# Callback for when a card is played
func _on_card_played(card_index):
	emit_signal("card_played", card_index)
	
# Callback when the end turn button is pressed
func _on_end_turn_button_pressed():
	emit_signal("end_turn_pressed")
