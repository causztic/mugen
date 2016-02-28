MusicVisuals = (canvas, width, height, audio) ->
  _this = this
  _this.canvas = canvas
  _this.width = width
  _this.height = height
  _this.canvasCtx = canvas.getContext('2d')
  _this.audio = audio

  _this.audioCtx = new ((window.AudioContext or window.webkitAudioContext))
  _this.analyser = this.audioCtx.createAnalyser()
  _this.analyser.fftSize = 512
  _this.bufferLength = this.analyser.frequencyBinCount
  _this.dataArray = new Uint8Array(this.bufferLength)

  _this.canvasCtx.clearRect 0, 0, width, height

  update = ->
    requestAnimationFrame update
    _this.canvasCtx.save()
    _this.analyser.getByteFrequencyData _this.dataArray
    #canvasCtx.globalAlpha = 0.1;
    _this.canvasCtx.fillStyle = '#f8f8f8'
    #canvasCtx.globalAlpha = 1;
    _this.canvasCtx.fillRect 0, 0, _this.width, _this.height * 2
    _this.canvasCtx.restore()
    barWidth = _this.width / _this.bufferLength * 2.5
    barHeight = undefined
    x = 0
    i = 0
    while i < _this.bufferLength
      barHeight = _this.dataArray[i] / 1.4
      _this.canvasCtx.fillStyle = '#FF0000'
      _this.canvasCtx.fillRect x, _this.height * 2 - barHeight, barWidth, barHeight
      _this.canvasCtx.restore()
      x += barWidth + 1
      i++
    return

  update()

  $(audio).bind 'canplay', ->
    rem = parseInt($(this).get(0).duration, 10)
    mins = Math.floor(rem / 60, 10)
    secs = rem - (mins * 60)
    $('#time-total').text mins + ':' + (if secs > 9 then secs else '0' + secs)
    source = _this.audioCtx.createMediaElementSource(this)
    source.connect _this.analyser
    _this.analyser.connect _this.audioCtx.destination

@MusicPlayer = React.createClass
  playMusic: ->
    audio = $('#player')[0]
    audio.pause()
    audio.load()
    audio.oncanplaythrough = audio.play()
    return audio

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
    $('#play-button').addClass('glyphicon-pause').removeClass 'glyphicon-play'
    $('#player').show()
    audio = this.playMusic()
    $('#play-controls').fadeIn()
    this.updateBackground()
    canvas = ReactDOM.findDOMNode(this.refs.canvas)
    this._viz = new MusicVisuals(canvas, this.props.width, this.props.height, audio)

  componentWillUnmount: ->
    # console.log "unmounted"
    # TODO: clear variables here.

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
          <canvas ref="canvas" className="center" id="visualization"></canvas>
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