class_name Building
extends StaticBody2D

## Represents a faction's building.


@export_group("Stats")
## The health of the building.
@export var health: float = 1000

@onready var fires = $Fires.get_children()
var fires_index = 0


## Spawns a fire
func spawn_fire() -> void:
	var fire: Fire = fires[fires_index]
	fire.start()
	if fires_index < fires.size() - 1:
		fires_index += 1

func extinguish_fire() -> void:
	if fires_index >= 0:
		var fire: Fire = fires[fires_index]
		fire.stop()
		fires_index -= 1


