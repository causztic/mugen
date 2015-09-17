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
    canvasCtx.fillStyle = "#f8f8f8";
    //canvasCtx.globalAlpha = 1;
    canvasCtx.fillRect(0, 0, WIDTH, HEIGHT*2);
    canvasCtx.restore();
    var barWidth = (WIDTH / bufferLength) * 2.5;
    var barHeight;
    var x = 0;
    for(var i = 0; i < bufferLength; i++) {
      barHeight = dataArray[i]/1.4;
      canvasCtx.fillStyle="#FF0000";
      canvasCtx.fillRect(x,HEIGHT*2-barHeight,barWidth,barHeight);
      canvasCtx.restore();
      x += barWidth + 1;
    };
  };

  // time left and seeker
  $("#player").bind('timeupdate', function() {

    var rem = parseInt($(this).get(0).currentTime, 10),
    pos = (audioCtx.currentTime / audioCtx.duration) * 100,
    mins = Math.floor(rem/60,10),
    secs = rem - mins*60;

    $("#time-passed").text(mins + ':' + (secs > 9 ? secs : '0' + secs));
    //if (!manualSeek) { positionIndicator.css({left: pos + '%'}); }

  });

  // Hook up the audio routing...
  // player -> analyser -> speakers
  // (Do this after the player is ready to play - https://code.google.com/p/chromium/issues/detail?id=112368#c4)
  $("#player").bind('canplay', function() {
    try {
      var rem = parseInt($(this).get(0).duration, 10),
      mins = Math.floor(rem/60,10),
      secs = rem - mins*60;
      $("#time-total").text(mins + ':' + (secs > 9 ? secs : '0' + secs));

      var source = audioCtx.createMediaElementSource(this);
      source.connect(analyser);
      analyser.connect(audioCtx.destination);
    } catch (e){
      //do nothing
    }
  });

  // Kick it off...
  update();
});