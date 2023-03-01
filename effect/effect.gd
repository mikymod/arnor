class_name Effect
extends Node

export(Resource) var resource

var card

func init(card, resource) -> void:
	self.card = card
	self.resource = resource
