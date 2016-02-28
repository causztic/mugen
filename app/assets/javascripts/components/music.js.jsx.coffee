@MusicFile = React.createClass
  componentDidMount: ->
    # console.log "mounted"
  componentWillUnmount: ->
    # console.log "unmounted"
  playMusic: ->
    ReactDOM.render(`<MusicPlayer id={this.props.id} title={this.props.title} artist={this.props.artist} 
      album={this.props.album} cover_image={this.props.cover_image} path={this.props.path}/>`, document.getElementById('viz'))
  render: ->
    # backticks are required for jsx components in coffeescript.
    `<div className='col-sm-3 col-xs-6'>
     <div className='music box' id={this.props.id} onClick={this.playMusic}>
      <div className='overlay-bg' />
      <div className='overlay' >
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
      </div>
    </div>`
