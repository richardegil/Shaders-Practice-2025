precision highp float;

uniform vec2 uResolution;
uniform float uTime;

float random (in vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))
                * 43758.5453123);
}

// Value noise by Inigo Quilez - iq/2013
// https://www.shadertoy.com/view/lsf3WH
float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);
    vec2 u = f*f*(3.0-2.0*f);
    return mix( mix( random( i + vec2(0.0,0.0) ),
                     random( i + vec2(1.0,0.0) ), u.x),
                mix( random( i + vec2(0.0,1.0) ),
                     random( i + vec2(1.0,1.0) ), u.x), u.y);
}

void main() {	
	vec2 uv = (gl_FragCoord.xy - (uResolution.xy * 0.5)) / uResolution.y;
  vec3 color = vec3(0.0);

  float amount = 10.0;
  int iAmount = 40;

  for(int i = 0; i < 40; i++){
    float radius = 0.4 * noise(uv) / (sin(uTime * 0.25)) * (cos(uTime * 0.25));
    float rad = radians(360.0 / amount) * float(i);

    color += 0.003 / length(uv + vec2((radius) * cos(rad), (radius) * sin(rad)));
  }
  vec3 c1 = vec3(0.5, 0.0, 1.0);
	vec3 c2 = vec3(1.0, 1.0, 0.0);
	
	color = mix(c1, c2, color);
  gl_FragColor = vec4(color, 1.0);
}