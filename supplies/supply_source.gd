class_name SupplySource
extends Node2D

## Base class for a source of supplies.
## GoldMine and PineTree extends from this.

@export var supply: Supply
@export var amount: int = 10

func pop_resource() -> void:
	supply.add(amount)
