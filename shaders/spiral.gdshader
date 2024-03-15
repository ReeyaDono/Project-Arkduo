shader_type canvas_item;

uniform float speed : hint_range(0.0, 10.0) = 2.0;

float circle(vec2 position, float radius, float feather)
{
	return smoothstep(radius, radius + feather, length(position - vec2(0.5)));
}

void fragment() {
	vec2 uv_cartesian = UV * 2.0 - 1.0;
	float angle = atan(uv_cartesian.x, uv_cartesian.y);
	angle /= TAU;
	angle += 0.5;
	float strength = cos(angle * 100.0 + (TIME*speed));
	strength = step(0.5, strength);
	
	COLOR.rgb = vec3(strength);
	COLOR.a = 1.0 - circle(UV, 0.5, 0.005);
}
