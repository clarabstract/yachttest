http = require 'http'
html = require './htmlbuilder'

console.log html

server = http.createServer (request, response)->
    response.writeHead 200, 'Content-Type':'text/plain'
    response.write html.tag('html')
    response.end '\n'

server.listen(8124)

console.log 'Server running at http://127.0.0.1:8124'
