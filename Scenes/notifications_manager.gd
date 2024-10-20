class_name NotificationsManager
extends Node

signal on_notification(text: String, icon: Texture2D)

func notify(text: String, icon: Texture2D = null):
	print("Notify: \"%s\"" % text)
	on_notification.emit(text, icon)
