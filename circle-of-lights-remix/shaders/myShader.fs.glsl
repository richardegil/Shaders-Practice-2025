precision highp float;

uniform vec2 uResolution;
uniform float uTime;


void main() {	
	vec2 uv = (gl_FragCoord.xy - (uResolution.xy * 0.5)) / uResolution.y;
  vec3 color = vec3(0.5, 0.2, 0.7);

  float amount = 40.0;
  int iAmount = 40;


  for(int i = 0; i < 40; i++){
    float radius = 0.4;
    float rad = radians(360.0 / amount) * float(i) * uTime * 0.25;

    color += 0.003 / length(uv + vec2((radius * cos(uTime)) * cos(rad), (radius * sin(uTime)) * sin(rad)));
  }

  for(int i = 0; i < 40; i++){
    float radius = 0.2;
    float rad = radians(360.0 / amount) * float(i) * uTime * 0.125;

    color -= 0.001 / length(uv + vec2((radius * cos(uTime)) * cos(rad), (radius * sin(uTime)) * sin(rad)));
  }

  for(int i = 0; i < 50; i++){
    float radius = 0.5;
    float rad = radians(360.0 / amount) * float(i) * uTime * 0.5;

    color -= 0.003 / length(uv + vec2((radius * cos(uTime)) * cos(rad), (radius * sin(uTime)) * sin(rad)));
  }
  gl_FragColor = vec4(color, 1.0);
}