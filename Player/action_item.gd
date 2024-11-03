extends PanelContainer

func fill(action: Action):
	tooltip_text = str(action)
	%IconTexture.texture = action.icon
