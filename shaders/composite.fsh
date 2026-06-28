#version 120

#include "/common/realistic_lite.glsl"

uniform sampler2D gcolor;
uniform sampler2D depthtex0;
uniform float viewWidth;
uniform float viewHeight;

varying vec2 vTexCoord;

float rlsDither(vec2 uv) {
    vec2 pixel = floor(uv * vec2(viewWidth, viewHeight));
    return fract(sin(dot(pixel, vec2(12.9898, 78.233))) * 43758.5453);
}

void main() {
    vec3 color = texture2D(gcolor, vTexCoord).rgb;
    float depth = texture2D(depthtex0, vTexCoord).r;

    float edgeDistance = length(vTexCoord - vec2(0.5));
    float vignette = smoothstep(0.88, 0.26, edgeDistance);
    color *= mix(0.96, 1.00, vignette);

    float skyBlend = smoothstep(0.996, 1.0, depth);
    color = mix(color, min(color, vec3(0.92)), skyBlend * 0.18);
    color += (rlsDither(vTexCoord) - 0.5) / 255.0;

    gl_FragData[0] = vec4(clamp(color, 0.0, 1.0), 1.0);
}
