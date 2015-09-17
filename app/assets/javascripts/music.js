$(document).ready(function(){
    $('.grid').masonry({
      itemSelector: '.music'
    });
    $(".music").click(function(){
        var current_music = $(this);
        $("#player").show();
        var audio = $("#player");
        $("#currentsong").attr("src", current_music.find(".music-item").data("url"));
        $("#music-title").html(current_music.find(".music-item").data("title"));
        $("#music-artist").html(current_music.find(".music-item").data("artist"));
        $("#music-album").html(current_music.find(".music-item").data("album"));
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
})