shader_type canvas_item;
uniform vec4 color : source_color;

void fragment(){
	vec4 tex_color = texture(TEXTURE,UV);
	COLOR = vec4(color.rgb, tex_color.a * color.a);
}