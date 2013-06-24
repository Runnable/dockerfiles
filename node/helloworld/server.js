var http = require('http');
var redis = require("redis").createClient();

http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  redis.get("foo", function (err, data) {
    res.end(data);
    console.log(data);
  });
}).listen(80);
console.log('Hello Kitty');
redis.set("foo", "bar");
setInterval(function () {
  console.log('foo');
}, 3000);
