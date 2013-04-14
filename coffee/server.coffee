
# {rain, boots} = require "rain-boots"
events = require "events"
ws = require "ws"
http = require "http"
path = require "path"
fs = require "fs"
chokidar = require "chokidar"

client = path.join __dirname, 'client.js'
interval = 600
revive = 4000

exports.rain = new events.EventEmitter()

ws_server_on = (port) ->
  WebSocketServer = require('ws').Server
  wss = new WebSocketServer port: port, host: '0.0.0.0'
  wss.on 'connection', (ws) ->
    # console.log 'connection'
    reload = -> ws.send "reload"
    exports.rain.on "reload", reload
    ws.on 'close', ->
      exports.rain.removeListener "reload", reload

http_server_on = (http_port, ws_port) ->
  app = http.createServer (req, res) ->
    # show 'a request'
    res.writeHead 200, 'Content-Type': 'text/javascript'
    fs.readFile client, "utf8", (err, content) ->
      throw err if err
      content = content
        .replace("7776", ws_port)
        .replace("4000", revive)
      res.end content
  app.listen http_port

started = no

exports.rain.on "server", (data) ->
  data = data or {}
  unless started
    started = yes
    http_port = data.http or 7777
    ws_port = data.ws or 7776
    interval = data.interval if data.interval?
    revive = data.revive if data.revive?

    http_server_on http_port, ws_port
    ws_server_on ws_port
    exports.rain.emit "started"

make_time = -> (new Date).getTime()
time_stamp = make_time()
notify_reload = ->
  # console.log "an event"
  time = make_time()
  if (time - time_stamp) > interval
    exports.rain.emit "reload"

exports.rain.on "watch", (path_names...) ->
  path_names.forEach (path_name) ->
    watcher = chokidar.watch path_name
    watcher.on "change", notify_reload
    exports.rain.emit "watched", path_name