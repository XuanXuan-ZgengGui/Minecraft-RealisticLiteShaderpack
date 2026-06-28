#version 120

#include "/common/realistic_lite.glsl"

varying vec4 vColor;

void main() {
    vec3 sky = rlsSkyGrade(vColor.rgb);
    gl_FragData[0] = vec4(sky, vColor.a);
}
