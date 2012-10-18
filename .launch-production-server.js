var express = require('express')
var app     = express()
var port    = process.env.PORT || 3333

app.use(express.static('.public'))
app.get('*', function(req, res){ res.sendfile('.public/index.html')  })

app.listen(port)
console.log('listening on port ' + port)
