shader_type canvas_item;
uniform vec4 received_color=vec4(0.1,0.3,1.0,1.0);
void fragment()
{
    vec4 original_color = texture(TEXTURE, UV);
	vec4 final_color;
	final_color=original_color*received_color;
	COLOR=final_color;
}