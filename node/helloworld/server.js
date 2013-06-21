var http = require('http');
var redis = require("redis").createClient();

http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  redis.get("foo", function (err, data) {
    res.end(data);
  });
}).listen(80);
console.log('Hello Kitty');
redis.set("foo", "bar");
