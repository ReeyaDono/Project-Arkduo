shader_type canvas_item;

float circle(vec2 position, float radius, float feather)
{
	return smoothstep(radius, radius + feather, length(position - vec2(0.5)));
}

void fragment() {
	COLOR.a = 1.0 - circle(UV, 0.5, 0.005);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
