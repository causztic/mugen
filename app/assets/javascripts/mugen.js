// $(document).ready(function() {

//   // //get audio context and create an analyser//
//   // var audioCtx = new (window.AudioContext || window.webkitAudioContext)(); 
//   // var analyser = audioCtx.createAnalyser();

//   // //fast fourier transform size. the bigger the number, the more bars will appear.
//   // analyser.fftSize = 512;

//   // var bufferLength = analyser.frequencyBinCount;
//   // var dataArray = new Uint8Array(bufferLength);
//   // var WIDTH = 360;
//   // var HEIGHT = 100;

//   // //specify the canvas
//   // var canvas = document.querySelector('canvas');
//   // var canvasCtx = canvas.getContext('2d');

//   // canvasCtx.clearRect(0, 0, WIDTH, HEIGHT);
//   // var source;
//   // var audio = $("#player")[0];
//   // var loadingIndicator = $("#loading");
//   // var manualSeek = false;
//   // var loaded = 0;

//   // function update() {
//   //   requestAnimationFrame(update);
//   //   canvasCtx.save();
//   //   analyser.getByteFrequencyData(dataArray);
//   //   //canvasCtx.globalAlpha = 0.1;
//   //   canvasCtx.fillStyle = "#f8f8f8";
//   //   //canvasCtx.globalAlpha = 1;
//   //   canvasCtx.fillRect(0, 0, WIDTH, HEIGHT*2);
//   //   canvasCtx.restore();
//   //   var barWidth = (WIDTH / bufferLength) * 2.5;
//   //   var barHeight;
//   //   var x = 0;
//   //   for(var i = 0; i < bufferLength; i++) {
//   //     barHeight = dataArray[i]/1.4;
//   //     canvasCtx.fillStyle="#FF0000";
//   //     canvasCtx.fillRect(x,HEIGHT*2-barHeight,barWidth,barHeight);
//   //     canvasCtx.restore();
//   //     x += barWidth + 1;
//   //   };
//   // };

//   // Hook up the audio routing...
//   // player -> analyser -> speakers
//   // (Do this after the player is ready to play - https://code.google.com/p/chromium/issues/detail?id=112368#c4)
//   $(audio).bind('canplay', function() {
//     try {
//       var rem = parseInt($(this).get(0).duration, 10),
//       mins = Math.floor(rem/60,10),
//       secs = rem - mins*60;
//       $("#time-total").text(mins + ':' + (secs > 9 ? secs : '0' + secs));
//       source = audioCtx.createMediaElementSource(this);
//       source.connect(analyser);
//       analyser.connect(audioCtx.destination);
//     } catch (e){
//       //do nothing
//       //console.log(e);
//     }
//   });

//   $(audio).bind('timeupdate', function() {

//     var rem = parseInt(audio.currentTime, 10),
//     val = (100 / audio.duration) * audio.currentTime,
//     mins = Math.floor(rem/60,10),
//     secs = rem - mins*60;
//     // Update the slider value
//     $("#seek-bar").val(val);
//     $("#time-passed").text(mins + ':' + (secs > 9 ? secs : '0' + secs));
//   });
//   // Kick it off...
//   // update();


  
//   // $('.grid').masonry({
//   //   itemSelector: '.music'
//   // });

//   // Event listener for the seek bar
//   $("#seek-bar").on("change", function() {
//     // Calculate the new time
//     var time = audio.duration * ($(this).val() / 100);
//     // Update the audio time
//     console.log(time);
//     audio.currentTime = time;
//   });

//   //when buttons are clicked
//   $("#play-button").click(function(){
//       if ( $(this).hasClass("glyphicon-pause") ) {
//           //pause
//           audio.pause();
//       } else {
//           //play
//           audio.play();
//       }
//       $(this).toggleClass("glyphicon-pause").toggleClass("glyphicon-play");
//   })
  
// //   $(".music").click(function(){
// //       $("#play-button").addClass("glyphicon-pause").removeClass("glyphicon-play");
// //       var current_music = gon.music[$(this).attr("id")];
// //       $("#player").show();
// //       $("#currentsong").attr("src", current_music.path);
// //       $("#music-title").html(current_music.title);
// //       $("#music-artist").html(current_music.artist);
// //       $("#music-album").html(current_music.album);

// //       //update with new audio file
// //       audio.pause();
// //       audio.load();
// //       audio.oncanplaythrough = audio.play();

// //       $("#play-controls").fadeIn();

// //       $(".album-img").hide();
// //       $(".album-img").attr("src", current_music.cover_image);
// //       $(".album-img").fadeIn();

// //       $(".title-bg").hide();
      
// //       //for some reason current_music.cover_image does not work?!? wtf
// //       $(".title-bg").css("background", 'url(' + $(this).find("img")[0].src + ')');

// //       $(".title-bg").css("background-repeat", "no-repeat");
// //       $(".title-bg").css("background-position", "center center");
// //       $(".title-bg").css("background-size", "cover");
// //       $(".title-bg").fadeIn();
// //   });
// });