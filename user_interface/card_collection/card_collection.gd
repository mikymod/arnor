extends Control

@export var card_pile_resource: CardPileResource

@export var card_item: PackedScene

func _ready() -> void:
	for card: CardResource in card_pile_resource.owned_cards:
		var item = card_item.instantiate() as CardCollectionItem
		item.card = card
		_add_card_to_collection(item)
	for card: CardResource in card_pile_resource.unowned_cards:
		var item = card_item.instantiate()
		item.card = card
		_remove_card_from_collection(item)

func _remove_card_from_collection(item: CardCollectionItem) -> void:
	card_pile_resource.add_card(item.card)
	if item.pressed.is_connected(func(): _add_card_to_collection(item)):
		item.pressed.disconnect(func(): _add_card_to_collection(item))
	if item.get_parent() != null:
		item.get_parent().remove_child(item)
	item.pressed.connect(func(): _add_card_to_collection(item))
	$UnownedScrollContainer/GridContainer.add_child(item)
	
func _add_card_to_collection(item: CardCollectionItem) -> void:
	card_pile_resource.remove_card(item.card)
	if item.pressed.is_connected(func(): _remove_card_from_collection(item)):
		item.pressed.disconnect(func(): _remove_card_from_collection(item))
	if item.get_parent() != null:
		item.get_parent().remove_child(item)
	item.pressed.connect(func(): _remove_card_from_collection(item))
	$OwnedScrollContainer/GridContainer.add_child(item)
	sort()
	
func sort() -> void:
	$OwnedScrollContainer/GridContainer.get_children().sort_custom(
		func(a: Node, b: Node): return a.card.name.naturalnocasecmp_to(b.card.name) < 0
	)
	
