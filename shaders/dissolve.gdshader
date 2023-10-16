shader_type canvas_item;

uniform sampler2D dissolve_texture;
uniform float     dissolve_rate : hint_range(0.0, 1.0) = 0.5;

float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}

void fragment() {
	vec4 pixel_color = texture(TEXTURE, UV);
	// since the texture is grayscaled already we can use any color do determine its brightness
	float dissolve_brightness = texture(dissolve_texture, UV).r;
	COLOR = pixel_color;
	COLOR.a *= step(dissolve_rate, dissolve_brightness);
	float dissolve_Diff = abs(dissolve_brightness - dissolve_rate);
	float color_randomizer = 0.2 + random(UV) * 0.5;
	COLOR.rgb += vec3(1.0 - COLOR.r , color_randomizer - COLOR.g ,0.0 - COLOR.b) * step(dissolve_Diff, 0.05) * step(0.01, dissolve_rate);

}
