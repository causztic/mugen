
@MusicFile = React.createClass
  componentDidMount: ->
    # console.log "mounted"
  componentWillUnmount: ->
    # console.log "unmounted"
  playMusic: ->
    ReactDOM.render(`<MusicPlayer id={this.props.id} title={this.props.title} artist={this.props.artist} 
      album={this.props.album} cover_image={this.props.cover_image} path={this.props.path}/>`, document.getElementById('viz'))
    # $('#play-button').addClass('glyphicon-pause').removeClass 'glyphicon-play'
    # $('#player').show()
    # $('#currentsong').attr 'src', this.props.path
    # $('#music-title').html this.props.title
    # $('#music-artist').html this.props.artist
    # $('#music-album').html this.props.album
    # #update with new audio file
    # audio.pause()
    # audio.load()
    # audio.oncanplaythrough = audio.play()
    # $('#play-controls').fadeIn()
    # $('.album-img').hide()
    # $('.album-img').attr 'src', this.props.cover_image
    # $('.album-img').fadeIn()
    # $('.title-bg').hide()
    # #for some reason this.props.cover_image does not work?!? wtf
    # $('.title-bg').css 'background', 'url(' + $(this).find('img')[0].src + ')'
    # $('.title-bg').css 'background-repeat', 'no-repeat'
    # $('.title-bg').css 'background-position', 'center center'
    # $('.title-bg').css 'background-size', 'cover'
    # $('.title-bg').fadeIn()
  render: ->
    # backticks are required for jsx components in coffeescript.
    `<div className='col-sm-3 col-xs-6 music box' id={this.props.id}>
      <div className='overlay-bg' />
      <div className='overlay' onClick={this.playMusic}>
        <h3>{this.props.title}</h3>
        <h3>{this.props.artist}</h3>
        <h3>{this.props.album}</h3>
      </div>
      <img src={this.props.cover_image} />
      <div className='row'>
        <div className='col-xs-6 music-details'>
          <h3>{this.props.title}</h3>
          <h3 className='subheader'>{this.props.album}</h3>
        </div>
        <div className='col-xs-6'>
          <h3 className='right'>{this.props.artist}</h3>
        </div>
      </div>
    </div>`
