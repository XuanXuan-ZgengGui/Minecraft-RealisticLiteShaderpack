#version 120

uniform sampler2D gcolor;

varying vec2 vTexCoord;

void main() {
    vec3 color = texture2D(gcolor, vTexCoord).rgb;
    color = clamp(color, 0.0, 1.0);
    gl_FragColor = vec4(color, 1.0);
}
