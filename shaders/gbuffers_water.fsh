#version 120

#include "/common/realistic_lite.glsl"

uniform sampler2D texture;
uniform sampler2D lightmap;
uniform vec3 fogColor;
uniform float frameTimeCounter;

varying vec2 vTexCoord;
varying vec2 vLightmapCoord;
varying vec4 vColor;
varying vec3 vWorldPosition;
varying vec3 vViewDirection;
varying float vViewDistance;

void main() {
    vec4 albedo = texture2D(texture, vTexCoord) * vColor;
    vec3 light = max(texture2D(lightmap, vLightmapCoord).rgb, vec3(0.16));
    vec3 lightDir = normalize(vec3(0.35, 0.82, 0.44));
    vec3 water = rlsWaterColor(albedo.rgb * light, normalize(vViewDirection), lightDir, vWorldPosition.xz, frameTimeCounter);
    water = rlsAtmosphere(water, vViewDistance, fogColor);

    float alpha = max(albedo.a, 0.50);
    gl_FragData[0] = vec4(rlsColorGrade(water), alpha);
}
