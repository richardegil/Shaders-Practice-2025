/* ------------------------------ */
// PROJECT INFO
/* ------------------------------ */
// Remix of Circle of Lights by Lewis Lepton

/* ------------------------------ */
// VARIABLES
/* ------------------------------ */
let canvas;
let pixelDensityValue = 1;
let myShader;

/* ------------------------------ */
// TWEAKPANE
/* ------------------------------ */
let debugFont;
let showTweaks = 0;
const PARAMS = {
  moment: 0.43,
  noiseScale: 0.1,
  noiseOffset: 3,
	debug: true,
};

function preload() {
  debugFont = loadFont('https://cdnjs.cloudflare.com/ajax/libs/topcoat/0.8.0/font/SourceCodePro-Bold.otf');
  myShader = loadShader('./shaders/myShader.vs.glsl', './shaders/myShader.fs.glsl');
}

function setup() {
  pixelDensity(pixelDensityValue); // Force pixel density to 1 for consistent behavior
  canvas = createCanvas(windowWidth, windowHeight, WEBGL);
  // myShader = createShader(vertexShader, fragmentShader);
  shader(myShader);
	frameRate(30);
  noStroke();
  
  textFont(debugFont);
  textSize(16);
  textAlign(LEFT, TOP);
}

function draw() {
  background(220);
  
  // Update shader uniforms
  myShader.setUniform('uResolution', [width * pixelDensityValue, height * pixelDensityValue]);
  myShader.setUniform('uTime', millis() / 1000.0);
  myShader.setUniform('uPixelDensity', pixelDensity());
	
  // Draw the full-screen quad
  push();
		translate(0, 0, 0);
		plane(width, height);
  pop();
	
	if(PARAMS.debug == true && showTweaks == 1) {
		showDebug();
	}
}

if (showTweaks == 1) {
	
	const pane = new Tweakpane.Pane();
	pane.addInput(PARAMS, 'debug');
	pane.addInput(PARAMS, 'moment', {
		min: 0,
		max: 1,
		step: 0.001,
	});
	pane.addInput(PARAMS, 'noiseScale', {
		min: 0,
		max: 10,
		step: 0.01,
	});
	pane.addInput(PARAMS, 'noiseOffset', {
		min: 0,
		max: 100,
		step: 0.01,
	});

	const saveBtn = pane.addButton({
		title: 'Save',
		label: ''
	});
	
	saveBtn.on('click', () => {
		saveImage();
	});
}

function windowResized() {
  resizeCanvas(windowWidth, windowHeight);
}

function saveImage() {
  save(`reg_.png`);
}

function showDebug() {
	// Draw debug info
  push();
  ortho();
  translate(-width/2, -height/2, 0);
  fill(0);
  text(`Window: ${windowWidth} x ${windowHeight}`, 10, 10);
  text(`Canvas: ${width} x ${height}`, 10, 30);
  text(`Pixel Density: ${pixelDensity()}`, 10, 50);
  pop();
  
  // Draw crosshair at center
  push();
  stroke(255, 255, 0);
  strokeWeight(2);
  line(-10, 0, 10, 0);
  line(0, -10, 0, 10);
  pop();
}