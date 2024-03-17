extends PanelContainer

@export var encounter_res: EncounterResource = preload("res://encounter/encounter_res.tres")

func _ready() -> void:
	$VBoxContainer/EncounterDifficulty/DifficultySlider.value = encounter_res.difficulty
	$VBoxContainer/EncounterDifficulty/SliderValue.text = str(encounter_res.difficulty)
	
func _on_difficulty_slider_value_changed(value):
	encounter_res.difficulty = value
	$VBoxContainer/EncounterDifficulty/DifficultySlider.value = value
	$VBoxContainer/EncounterDifficulty/SliderValue.text = str(encounter_res.difficulty)
