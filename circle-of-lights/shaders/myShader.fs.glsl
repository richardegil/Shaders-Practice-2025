precision highp float;

uniform vec2 uResolution;
uniform float uTime;


void main() {	
	vec2 uv = (gl_FragCoord.xy - (uResolution.xy * 0.5)) / uResolution.y;
  vec3 color = vec3(0.0);

  float amount = 40.0;
  int iAmount = 40;

  for(int i = 0; i < 40; i++){
    float radius = 0.4;
    float rad = radians(360.0 / amount) * float(i);

    color += 0.003 / length(uv + vec2((radius) * cos(rad), (radius) * sin(rad)));
  }

  gl_FragColor = vec4(color, 1.0);
}