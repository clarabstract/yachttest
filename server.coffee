http = require 'http'
html = require './htmlbuilder'

application = require './application'
router = require './router'

app = new application.Application 'blog'
router.route(app)

app.register_resources './post'

console.log app.root_router.compile()
server = http.createServer (request, response)->
    response.writeHead 200, 'Content-Type':'text/html'
    html.build response, ->
        @html =>
            @body =>
                @h1 'what'
    response.end '\n'

server.listen(8124)

console.log 'Server running at http://127.0.0.1:8124'
