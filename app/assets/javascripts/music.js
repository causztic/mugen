$(document).ready(function(){
    var audio = $("#player");
    
    $('.grid').masonry({
      itemSelector: '.music'
    });

    $("#play-button").click(function(){
        if ( $(this).hasClass("glyphicon-pause") ) {
            //pause
            audio[0].pause();
        } else {
            //play
            audio[0].play();
        }
        $(this).toggleClass("glyphicon-pause").toggleClass("glyphicon-play");
    })
    
    $(".music").click(function(){
        var current_music = gon.music[$(this).attr("id")];
        $("#player").show();
        $("#currentsong").attr("src", current_music.path);
        $("#music-title").html(current_music.title);
        $("#music-artist").html(current_music.artist);
        $("#music-album").html(current_music.album);


        audio[0].pause();
        audio[0].load();
        audio[0].oncanplaythrough = audio[0].play();
        $("#play-controls").fadeIn();

        $(".album-img").hide();
        $(".album-img").attr("src", current_music.cover_image);
        $(".album-img").fadeIn();

        $(".title-bg").hide();
        
        //for some reason current_music.cover_image does not work?!? wtf
        $(".title-bg").css("background", 'url(' + $(this).find("img")[0].src + ')');

        $(".title-bg").css("background-repeat", "no-repeat");
        $(".title-bg").css("background-position", "center center");
        $(".title-bg").css("background-size", "cover");
        $(".title-bg").fadeIn();
    });

})