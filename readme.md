
Doodle-boots, a reloader based on Websocket and Rain-boots
-----

### Usage

Installion via NPM. Rain-boots is optional for this plugin.  
For Rain-boots please read: https://github.com/jiyinyiyong/rain-boots

```
npm install doodle-boots
```

The events you may emit:

* `server`: create the servers for http and websocket
  
  Options:

  * `http`: `Number 7777`, to specify the port for `doodle.js` file  
  * `ws`: `Number 7776`, to specify the port of websocket  
  * `interval`: `Number 600`, the minimal interval of reload events  
  * `revive`: `Number 4000`, time it revives if broken  

* `watch`: watch a path for sending `reload` signal
  
  Option:

  * `String`: a string for the filename or dirname  
  * `[String]`: array of strings to watch  

The event you may listen:

* `started`: servers started. Will be emitted only once
* `watched`: you may got the path you watched...

What to do on browser side:

* Add `http://localhost:7777/doodle.js` to you scripts  
  Actually http server gives `doodle.js` every time, no need specify  
  Your address may be different from mime in `test/`

* This is currently not a stable project, fix it if it's broken