class_name DeckResource
extends Resource

@export var slots: Dictionary

@export var num_slots: int = 2

@export var max_slots: int = 6:
	get: return max_slots
	set(value): max_slots = value

func add_card(card: CardResource) -> bool:
	if slots.has(card): return false
	if slots.size() >= num_slots: return false
	slots[card] = true
	return true

func remove_card(card: CardResource) -> bool:
	return slots.erase(card)

func get_random() -> CardResource:
	return slots.keys().pick_random()

func increase_num_slots() -> void:
	if num_slots >= max_slots:
		return
	num_slots += 1

func decrease_num_slots() -> void:
	if num_slots <= 0: return
	num_slots -= 1

