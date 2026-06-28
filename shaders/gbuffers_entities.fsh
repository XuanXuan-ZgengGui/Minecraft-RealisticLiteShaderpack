#version 120

#include "/common/realistic_lite.glsl"

uniform sampler2D texture;
uniform sampler2D lightmap;
uniform vec3 fogColor;

varying vec2 vTexCoord;
varying vec2 vLightmapCoord;
varying vec4 vColor;
varying float vViewDistance;

void main() {
    vec4 albedo = texture2D(texture, vTexCoord) * vColor;
    if (albedo.a < 0.10) discard;

    vec3 light = texture2D(lightmap, vLightmapCoord).rgb;
    vec3 color = albedo.rgb * max(light, vec3(0.18));
    color = rlsAtmosphere(color, vViewDistance, fogColor);

    gl_FragData[0] = vec4(rlsColorGrade(color), albedo.a);
}
