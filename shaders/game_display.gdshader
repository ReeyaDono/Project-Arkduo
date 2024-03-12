shader_type canvas_item;

uniform sampler2D viewport_a : source_color;
uniform sampler2D viewport_b : source_color;
uniform sampler2D viewport_mask : source_color;

void fragment() {
	vec3 view_a = texture(viewport_a, UV).rgb;
	vec3 view_b = texture(viewport_b, UV).rgb;
	float view_mask = texture(viewport_mask, UV).r;
	
	if (view_mask == 1.0) {
		COLOR.rgb = view_a;
	} 
	else {
		COLOR.rgb = view_b;
	}
}
