#ifndef REALISTIC_LITE_GLSL
#define REALISTIC_LITE_GLSL

const float RLS_REALISM = 1.08;       // [0.80 0.90 1.00 1.08 1.16 1.25]
const float RLS_EXPOSURE = 1.04;      // [0.80 0.90 1.00 1.04 1.12 1.20]
const float RLS_SATURATION = 1.08;    // [0.85 0.95 1.00 1.08 1.15 1.25]
const float RLS_FOG_STRENGTH = 0.72;  // [0.40 0.55 0.72 0.85 1.00]
const float RLS_WATER_DETAIL = 0.80;  // [0.30 0.50 0.80 1.00]

float rlsLuma(vec3 color) {
    return dot(color, vec3(0.2126, 0.7152, 0.0722));
}

vec3 rlsSaturate(vec3 color, float amount) {
    float luma = rlsLuma(color);
    return mix(vec3(luma), color, amount);
}

vec3 rlsAces(vec3 color) {
    color *= RLS_EXPOSURE;
    const float a = 2.51;
    const float b = 0.03;
    const float c = 2.43;
    const float d = 0.59;
    const float e = 0.14;
    return clamp((color * (a * color + b)) / (color * (c * color + d) + e), 0.0, 1.0);
}

vec3 rlsColorGrade(vec3 color) {
    color = pow(max(color, vec3(0.0)), vec3(1.0 / 1.05));
    color = rlsSaturate(color, RLS_SATURATION);
    color = mix(color, vec3(rlsLuma(color)), 0.04 * RLS_REALISM);
    color = rlsAces(color);
    return pow(color, vec3(1.0 / 2.2));
}

vec3 rlsAtmosphere(vec3 color, float viewDistance, vec3 fogColor) {
    float fogAmount = 1.0 - exp(-viewDistance * 0.010 * RLS_FOG_STRENGTH);
    fogAmount = clamp(fogAmount, 0.0, 0.82);
    return mix(color, fogColor, fogAmount);
}

float rlsWave(vec2 position, float time) {
    float waveA = sin(position.x * 0.065 + time * 0.80);
    float waveB = cos(position.y * 0.052 - time * 0.65);
    float waveC = sin((position.x + position.y) * 0.030 + time * 0.45);
    return (waveA + waveB + waveC) * 0.333;
}

vec3 rlsWaterColor(vec3 baseColor, vec3 viewDir, vec3 lightDir, vec2 position, float time) {
    float wave = rlsWave(position, time) * RLS_WATER_DETAIL;
    float facing = pow(1.0 - clamp(abs(viewDir.y), 0.0, 1.0), 3.0);
    float highlight = pow(max(dot(normalize(vec3(wave * 0.18, 0.94, wave * 0.12)), lightDir), 0.0), 24.0);
    vec3 deepWater = vec3(0.045, 0.145, 0.205);
    vec3 shallowWater = vec3(0.115, 0.260, 0.315);
    vec3 water = mix(shallowWater, deepWater, facing * 0.72);
    water += highlight * vec3(0.65, 0.78, 0.88) * RLS_WATER_DETAIL;
    return mix(baseColor, water, 0.62);
}

#endif
