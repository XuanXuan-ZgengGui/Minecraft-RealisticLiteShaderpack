#version 120

varying vec4 vColor;
varying float vViewDistance;

void main() {
    vec4 viewPosition = gl_ModelViewMatrix * gl_Vertex;
    gl_Position = gl_ProjectionMatrix * viewPosition;
    vColor = gl_Color;
    vViewDistance = length(viewPosition.xyz);
}
