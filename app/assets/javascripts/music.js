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
    canvasCtx.fillStyle = '#f8f8f8';
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
  $("#player").bind('canplay', function() {
    var source = audioCtx.createMediaElementSource(this);
    source.connect(analyser);
    analyser.connect(audioCtx.destination);
  });

  // Kick it off...
  update();

  $(".music").click(function(){
    var current_music = $(this);
    var audio = $("#player");
    $("#currentsong").attr("src", current_music.find(".location").data("url"));
    audio[0].pause();
    audio[0].load();
    audio[0].oncanplaythrough = audio[0].play();
    $(".album-img").hide();
    $(".album-img").attr("src", current_music.find("img")[0].src);
    $(".album-img").fadeIn();
    $(".title-bg").hide();
    $(".title-bg").css("background", "url('" + current_music.find("img")[0].src + "')");
    $(".title-bg").css("background-repeat", "no-repeat");
    $(".title-bg").css("background-position", "center center");
    $(".title-bg").css("background-size", "cover");
    $(".title-bg").fadeIn();
  });
});