express = require 'express'
engines = require 'consolidate'
path = require 'path'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
logger = require 'morgan'

start = (route, handle, process) ->
  app = express()

  app.engine 'html', engines.hogan

  app.set 'view engine', 'html'
  app.set 'views', path.join(__dirname, '../frontend')

  app.use logger('dev')
  app.use cookieParser()
  app.use bodyParser()
  app.use express.static('/dest/core/frontend')

  app.get '/', (req, res) ->
    route(handle, '/', req, res)

  port = process.env.PORT ? 3000
  app.listen port
  console.log('Listening on port ' + port + ' of worker ' + process.pid)

module.exports.start = start