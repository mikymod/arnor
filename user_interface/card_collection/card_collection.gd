extends Control

@export var card_pile_resource: CardPileResource

@export var card_item: PackedScene

func _ready() -> void:
	for card: CardResource in card_pile_resource.owned_cards:
		var item = card_item.instantiate() as CardCollectionItem
		item.card = card
		item.pressed.connect(func(): _remove_card_from_collection(item))
		$OwnedScrollContainer/GridContainer.add_child(item)
	for card: CardResource in card_pile_resource.unowned_cards:
		var item = card_item.instantiate()
		item.card = card
		item.pressed.connect(func(): _add_card_to_collection(item))
		$UnownedScrollContainer/GridContainer.add_child(item)

func _remove_card_from_collection(item: CardCollectionItem) -> void:
	card_pile_resource.add_card(item.card)
	if item.pressed.is_connected(func(): _add_card_to_collection(item)):
		item.pressed.disconnect(func(): _add_card_to_collection(item))
	#$OwnedScrollContainer/GridContainer.remove_child(item)
	item.get_parent().remove_child(item)
	$UnownedScrollContainer/GridContainer.add_child(item)
	item.pressed.connect(func(): _add_card_to_collection(item))
	
func _add_card_to_collection(item: CardCollectionItem) -> void:
	# TODO: add missing method to resource
	if item.pressed.is_connected(func(): _remove_card_from_collection(item)):
		item.pressed.disconnect(func(): _remove_card_from_collection(item))
	#$UnownedScrollContainer/GridContainer.remove_child(item)
	item.get_parent().remove_child(item)
	$OwnedScrollContainer/GridContainer.add_child(item)
	item.pressed.connect(func(): _remove_card_from_collection(item))
	pass
