#version 120

#include "/common/realistic_lite.glsl"

uniform sampler2D texture;
uniform vec3 fogColor;

varying vec2 vTexCoord;
varying vec4 vColor;
varying float vViewDistance;

void main() {
    vec4 albedo = texture2D(texture, vTexCoord) * vColor;
    if (albedo.a < 0.10) discard;

    vec3 color = rlsAtmosphere(albedo.rgb, vViewDistance, fogColor);
    gl_FragData[0] = vec4(rlsColorGrade(color), albedo.a);
}
