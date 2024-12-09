  precision highp float;
  uniform vec2 uResolution;
  uniform float uTime;
  uniform float uPixelDensity;
  varying vec2 vTexCoord;

  void main() {
    vec2 uv = vTexCoord - 0.5;
    uv.x *= uResolution.x / uResolution.y;
    
    float freq = 10.0;
    float pattern = 
      abs(distance(fract(uv * freq), vec2(0.5)));
    pattern = step(0.05, pattern);
    
    float pattern2 = 
      fract(max(
        abs(uv.x),
        abs(uv.y)
      ) * freq - abs(sin(uTime * -0.05)));
    pattern = smoothstep(0.4 * sin(uTime), 0.5, pattern);
    
    vec3 color = vec3(pattern + pattern2, pattern2 - pattern, pattern2);
    gl_FragColor = vec4(color, 1.0);
  }