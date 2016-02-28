
@MusicPlayer = React.createClass

  loadAudioContext: ->
    audioCtx = new (window.AudioContext || window.webkitAudioContext)()
    analyser = audioCtx.createAnalyser()
    analyser.fftSize = this.props.fftSize
    bufferLength = analyser.frequencyBinCount
    dataArray = new Uint8Array(bufferLength)

    # specify the canvas
    canvas = document.querySelector('canvas')
    canvasCtx = canvas.getContext('2d')
    canvasCtx.clearRect 0, 0, this.props.width, this.props.height
    loadingIndicator = $('#loading')

  playMusic: ->
    audio = $('#player')[0]
    audio.pause()
    audio.load()
    audio.oncanplaythrough = audio.play()

  updateBackground: ->
    $('.title-bg').hide()
    $('.title-bg').css 'background', 'url(' + $(".album-img")[0].src + ')'
    $('.title-bg').css 'background-repeat', 'no-repeat'
    $('.title-bg').css 'background-position', 'center center'
    $('.title-bg').css 'background-size', 'cover'
    $('.title-bg').fadeIn()

  getDefaultProps: ->
    {
      width: 360,
      height: 100,
      fftSize: 512, # fast fourier transform size. the bigger the number, the more bars will appear.
      manualSeek: false }

  getInitialState: ->
    { 
      timeElapsed: 0, 
      timePassed: 0, 
      timeTotal: 0,
      loaded: 0 }

  componentDidMount: ->
    this.loadAudioContext()

    $('#play-button').addClass('glyphicon-pause').removeClass 'glyphicon-play'
    $('#player').show()
    this.playMusic()
    $('#play-controls').fadeIn()
    this.updateBackground()

  componentWillUnmount: ->
    # console.log "unmounted"
  componentDidUpdate: ->
    this.playMusic()
    this.updateBackground()
  render: ->
    `<div>
      <div className="row">
        <div className="col-xs-7">
          <h3 id="music-title">{this.props.title}</h3>
          <h3 className="subheader" id="music-artist">{this.props.artist}</h3>
          <h3 id="music-album">{this.props.album}</h3>
        </div>
        <div className="col-xs-5">
          <img className="album-img" src={this.props.cover_image}/>
        </div>
      </div>
      <div className="row">
        <div className="col-xs-12">
          <section id="audio"></section>
          <canvas className="center" id="visualization"></canvas>
          <audio id="player" preload="none">
            <source id="currentsong" src={this.props.path} type="audio/mpeg" />
          </audio>
        </div>
      </div>
      <div className="row" id="play-controls">
        <div className="col-xs-12">
          <input id="seek-bar" type="range" value={this.state.timeElapsed} />
        </div>
        <div className="col-xs-3">
          <h6 className="subheader" id="time-passed">{this.state.timePassed}</h6>
        </div>
        <div className="col-xs-3 col-xs-offset-6">
          <h6 className="subheader right" id="time-total">{this.state.timeTotal}</h6>
        </div>
        <div className="col-xs-3 col-xs-offset-9">
          <i aria-hidden="true" aria-label="pause" className="glyphicon glyphicon-pause right" id="play-button" />
        </div>
      </div>
    </div>`