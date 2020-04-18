extends RichTextLabel


func _on_Timer_timeout():
    if visible_characters < get_total_character_count():
        visible_characters = visible_characters + 1
    else:
        get_parent().get_parent().get_parent().get_parent().dialogue_finished_callback()