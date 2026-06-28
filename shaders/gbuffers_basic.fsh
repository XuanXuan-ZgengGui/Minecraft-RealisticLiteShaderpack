#version 120

#include "/common/realistic_lite.glsl"

varying vec4 vColor;
varying float vViewDistance;

uniform vec3 fogColor;

void main() {
    vec3 color = rlsAtmosphere(vColor.rgb, vViewDistance, fogColor);
    gl_FragData[0] = vec4(rlsColorGrade(color), vColor.a);
}
