$(document).ready(function() {

  //get audio context and create an analyser//
  var audioCtx = new (window.AudioContext || window.webkitAudioContext)(); 
  var analyser = audioCtx.createAnalyser();

  //fast fourier transform size. the bigger the number, the more bars will appear.
  analyser.fftSize = 512;


  var bufferLength = analyser.frequencyBinCount;
  var dataArray = new Uint8Array(bufferLength);
  var WIDTH = 360;
  var HEIGHT = 100;

  //specify the canvas
  var canvas = document.querySelector('canvas');
  var canvasCtx = canvas.getContext('2d');
  canvasCtx.clearRect(0, 0, WIDTH, HEIGHT);

  function update() {
    requestAnimationFrame(update);
    canvasCtx.save();
    analyser.getByteFrequencyData(dataArray);
    //canvasCtx.globalAlpha = 0.1;
    canvasCtx.fillStyle = '#f5f5f5';
    //canvasCtx.globalAlpha = 1;
    canvasCtx.fillRect(0, 0, WIDTH, HEIGHT*2);
    canvasCtx.restore();
    var barWidth = (WIDTH / bufferLength) * 2.5;
    var barHeight;
    var x = 0;
    for(var i = 0; i < bufferLength; i++) {
      barHeight = dataArray[i]/2;
      canvasCtx.fillStyle="#FF0000";
      canvasCtx.fillRect(x,HEIGHT*2-barHeight,barWidth,barHeight);
      canvasCtx.restore();
      x += barWidth + 1;
    };
  };

  // Hook up the audio routing...
  // player -> analyser -> speakers
  // (Do this after the player is ready to play - https://code.google.com/p/chromium/issues/detail?id=112368#c4)
  $(".introsong").bind('canplay', function() {
    var source = audioCtx.createMediaElementSource(this);
    source.connect(analyser);
    analyser.connect(audioCtx.destination);
  });

  // Kick it off...
  update();
});