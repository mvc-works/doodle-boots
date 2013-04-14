
doodle = require("../lib/").rain

# console.log doodle

doodle.emit "server"
doodle.on "watched", (name) -> console.log name
doodle.emit "watch", "./tree-dir", "test-file"
