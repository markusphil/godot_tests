shader_type canvas_item;

uniform vec4 flash_color : source_color = vec4(1.0);
uniform float flash_strength : hint_range(0.0, 1.0) = 0.5;

void fragment() {
	vec4 pixel_color = texture(TEXTURE, UV);
	pixel_color.rgb = mix(pixel_color.rgb, flash_color.rgb, flash_strength);
	COLOR = pixel_color;
}
