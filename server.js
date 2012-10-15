var statik = require('statik');
var server = statik.createServer('./.public');
var port = process.env.PORT || 3333
console.log('live at localhost:' + port)
server.listen(port);
