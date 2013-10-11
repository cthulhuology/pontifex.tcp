# UDP.coffee
#
# (c) 2013 Dave Goehrig <dave@dloh.org>
#

net = require 'net'

Tcp = (Bridge, Url) ->
	self = this
	[ proto, host, port, domain, exchange, key, queue, dest, path ] = Url.match(///([^:]+)://([^:]+):(\d+)/([^\/]*)/([^\/]*)/([^\/]*)/([^\/]*)/([^\/]*)/([^\/]*)///)[1...] # "tcp", "dloh.org", "9966", //, "source-exchange", "source-key", "source-queue", "dest-exchange", "dest-key"
	self.server = net.createServer (socket) ->
		proxy = send : (message) ->
			console.log "Sending #{message} to socket"
			socket.write message
		Bridge.connect domain, () ->
			Bridge.route exchange, key, queue
			Bridge.subscribe queue, proxy, (message) ->
				console.log "Sending #{message} to socket"
				socket.write message
		socket.on 'data', (data) ->
			console.log "Sending #{data} to #{dest}/#{path}"
			Bridge.send dest, path, "#{data}"

		socket.on 'end', () ->
			console.log "connection ended"

		socket.on 'error', (error) ->
			console.log "connection error #{error}"

		socket.on 'close', (error) ->
			console.log "connection closed"

	self.server.listen port, host, () ->
		console.log "Server listening"

module.exports = Tcp
