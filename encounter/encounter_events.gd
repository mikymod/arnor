class_name EncounterEvents
extends Resource

signal encounter_started()

signal restore_phase_started()
signal draw_phase_started()
signal wave_phase_started()

signal wave_cleared()

signal reward_phase_started()
signal reward_selected(card_resource: CardResource)

signal encounter_finished()
