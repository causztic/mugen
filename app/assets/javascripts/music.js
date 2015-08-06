$(document).ready(function() {
  var audioCtx = new (window.AudioContext || window.webkitAudioContext)();
  var analyser = audioCtx.createAnalyser();
  analyser.fftSize = 256;
  var bufferLength = analyser.frequencyBinCount;
  var dataArray = new Uint8Array(bufferLength);
  var WIDTH = 360;
  var HEIGHT = 100;

  var canvas = document.querySelector('canvas');
  var canvasCtx = canvas.getContext('2d');
  canvasCtx.clearRect(0, 0, WIDTH, HEIGHT);

  function update() {
    requestAnimationFrame(update);
    analyser.getByteFrequencyData(dataArray);
    canvasCtx.fillStyle = 'rgb(200, 200, 200)';
    canvasCtx.fillRect(0, 0, WIDTH, HEIGHT);
    var barWidth = (WIDTH / bufferLength) * 2.5;
    var barHeight;
    var x = 0;
    for(var i = 0; i < bufferLength; i++) {
      barHeight = dataArray[i]/2;

      canvasCtx.fillStyle = 'rgb(' + (barHeight+100) + ',50,50)';
      canvasCtx.fillRect(x,HEIGHT-barHeight/2,barWidth,barHeight);

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