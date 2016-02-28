@MusicComponent = React.createClass
	getInitialState: ->
		{ timeElapsed: 0 }
	componentDidMount: ->
		console.log "mounted"
	componentWillUnmount: ->
		console.log "unmounted"
	render: ->
		# backticks are required for jsx components in coffeescript.
		`<div class='row'>
			<div class='col-xs-7'>
				<h3 id='music-title' />
				<h3 class='subheader' id='music-artist' />
				<h3 id='music-album' />
			<div class='col-xs-5'>
				<img class='album-img' />
			</div>
			</div>
		</div>`