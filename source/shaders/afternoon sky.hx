package shaders;

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord.xy/iResolution.xy;
    float y = uv.y + sin(iTime + uv.x)*0.25 + 0.25;
    fragColor = vec4(1.0, y, 0.5, 1.0);
}
