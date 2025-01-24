extends RefCounted  # Use Reference for data-only classes

class_name Card  # This allows you to use `Card` as a type globally

var id: String
var name: String
var type: String
var cost: int
var effect: String
var attributes: Dictionary
var keywords: Array

# Method to apply the card's effect, based on its type and attributes
func apply_effect():
	match type:
		"Attack":
			# Example: Deal damage (you'll need to define how this interacts with enemies in your game)
			if attributes.has("damage"):
				return apply_attack_effect(attributes["damage"])
			return "No damage effect"

		"Energy":
			# Example: Gain energy
			if attributes.has("energyGain"):
				return apply_energy_effect(attributes["energyGain"])
			return "No energy effect"

		"Stabilization":
			# Example: Increase portal stability
			if attributes.has("stabilityGain"):
				return apply_stabilization_effect(attributes["stabilityGain"])
			return "No stabilization effect"

		"Utility":
			# Example: Utility effects like block or draw cards
			if attributes.has("cardDraw"):
				return apply_utility_card_effect(attributes["cardDraw"])
			if attributes.has("block"):
				return apply_utility_card_effect(attributes["block"])
			return "No utility effect"

		_:
			return "Unknown card type"

# Helper function to handle attack effects
func apply_attack_effect(damage: int):
	# This is where you define what happens when an attack card is played
	# For example, deal damage to an enemy
	return "Dealing " + str(damage) + " damage!"

# Helper function to handle energy effects
func apply_energy_effect(energy_gain: int):
	# This is where you define what happens when an energy card is played
	# For example, gain energy
	return "Gaining " + str(energy_gain) + " energy!"

# Helper function to handle stabilization effects
func apply_stabilization_effect(stability_gain: int):
	# This is where you define what happens when a stabilization card is played
	# For example, increase portal stability
	return "Increasing portal stability by " + str(stability_gain) + "%!"

# Helper function to handle utility effects
func apply_utility_card_effect(amount: int):
	# Handle utility effects, like blocking damage or drawing cards
	return "Utility effect applied with amount: " + str(amount)
