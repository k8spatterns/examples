http = require('http');
fs = require('fs');
server = http.createServer( function(req, res) {
    if (req.method == 'POST') {
        var body = '';
        req.on('data', function (data) {
          body += data;
        });
        req.on('end', function () {
          var resp = JSON.parse(body);
          console.log("Message received for processing:")
          console.log(
            ">>> ID: " + resp.id +
            " -- Duration: " + resp.duration +
            " -- Random: " + resp.random);
        });
    }
    else {
        console.log("!!! Method " + req.method + " is not supported");
      }
    res.writeHead(200);
    res.end();
  });

var port = 9009;
var host = "localhost";
server.listen(port, host);
console.log("==========================================")
console.log("Starting up random-generator Ambassador")
console.log("Listening at http://" + host + ":" + port);
console.log("==========================================")
