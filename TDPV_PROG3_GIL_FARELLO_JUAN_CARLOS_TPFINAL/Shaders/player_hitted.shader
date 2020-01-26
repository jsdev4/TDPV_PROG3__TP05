shader_type canvas_item;

uniform vec4 received_color=vec4(1,1,1,1.0);
uniform float glow=0.0;
void fragment()
{
    vec4 original_color = texture(TEXTURE, UV);
	vec4 final_color;
	final_color=original_color*received_color;
	COLOR=final_color;
	vec4 glow_tween = vec4(sin(TIME*20.0),sin(TIME*20.0),sin(TIME*20.0),original_color.a);
	if(glow>0.0)
	{
		COLOR= mix(original_color,glow_tween,0.7);
	}
}