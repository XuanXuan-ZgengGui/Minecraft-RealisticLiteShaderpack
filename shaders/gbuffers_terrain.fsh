#version 120

#include "/common/realistic_lite.glsl"

uniform sampler2D texture;
uniform sampler2D lightmap;
uniform vec3 fogColor;

varying vec2 vTexCoord;
varying vec2 vLightmapCoord;
varying vec4 vColor;
varying vec3 vWorldPosition;
varying float vViewDistance;

void main() {
    vec4 albedo = texture2D(texture, vTexCoord);
    if (albedo.a < 0.10) discard;

    vec3 light = texture2D(lightmap, vLightmapCoord).rgb;
    vec3 bounce = vec3(0.92, 0.96, 1.00) * 0.08;
    vec3 color = albedo.rgb * vColor.rgb * (light + bounce);

    float groundWarmth = clamp(1.0 - abs(vWorldPosition.y) * 0.012, 0.0, 1.0);
    color = mix(color, color * vec3(1.045, 1.020, 0.965), groundWarmth * 0.18 * RLS_REALISM);
    color = rlsAtmosphere(color, vViewDistance, fogColor);

    gl_FragData[0] = vec4(rlsColorGrade(color), albedo.a * vColor.a);
}
