@MusicPlayer = React.createClass
  getInitialState: ->
    { timeElapsed: 0, timePassed: 0, timeTotal: 0 }
  componentDidMount: ->
  componentWillUnmount: ->
    # console.log "unmounted"
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