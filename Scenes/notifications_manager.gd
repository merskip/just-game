class_name NotificationsManager
extends Node

signal on_notification(text: String)

func notify(text: String):
	print("Notify: \"%s\"" % text)
	on_notification.emit(text)
