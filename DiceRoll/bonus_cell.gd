extends Panel

func fill(bonus: Check.Bonus):
	%TitleLabel.text = bonus.name
	%IconTexture.texture = bonus.icon
	%ModifierLabel.text = "%+d" % bonus.modifier
