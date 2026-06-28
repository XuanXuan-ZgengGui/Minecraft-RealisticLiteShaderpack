#version 120

#include "/common/realistic_lite.glsl"

uniform sampler2D texture;

varying vec2 vTexCoord;
varying vec4 vColor;

void main() {
    vec4 tex = texture2D(texture, vTexCoord) * vColor;
    if (tex.a < 0.05) discard;

    float brightness = max(max(tex.r, tex.g), tex.b);
    vec3 color = mix(rlsSkyGrade(tex.rgb), rlsSunGrade(tex.rgb), smoothstep(0.72, 1.25, brightness));
    gl_FragData[0] = vec4(color, tex.a);
}
