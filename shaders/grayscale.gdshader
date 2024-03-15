shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

float circle(vec2 position, float radius, float feather)
{
	return smoothstep(radius, radius + feather, length(position - vec2(0.5)));
}

void fragment() {
	vec4 pixelColor = texture(SCREEN_TEXTURE, SCREEN_UV);
	float brightness = (pixelColor.r + pixelColor.g + pixelColor.b) / 3.0;
	COLOR.rgb = vec3(brightness);
	COLOR.a = 1.0 - circle(UV, 0.5, 0.005);
}
