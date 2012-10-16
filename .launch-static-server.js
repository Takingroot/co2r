var statik = require('statik');
var server = statik.createServer('./.public');
var port   = process.env.PORT || 9999
server.listen(port);
