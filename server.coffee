http = require 'http'
html = require './htmlbuilder'

class Page
    2 + 2   
    html: (builder)->
        page = this
        builder ->
            @html ->
                @head ->
                    @title page.title + " " + page.site_title
                    for script in page.scripts
                        @script script
                @body page.content
            
class Homepage extends Thing
    @register_url('/')
    @template = Page
    html:->
        @page = new @template()
        @page.title = "Welcome to Yacht Game" 
        @page.content = @builder ->
            @div '#welcome', "
                Thank you for coming to play yahtzee! Pleze to meet!
            "
        return @page.render(request)

class Game extends Thing
    @register_url(/^\/game\/(?<game_id>\d+)\/?$/)
    @register_url(/^\/game\/new\/?$/)
    
        


server = http.createServer (request, response)->
    response.writeHead 200, 'Content-Type':'text/plain'
    response.write html.tag('html')
    response.end '\n'

server.listen(8124)

console.log 'Server running at http://127.0.0.1:8124'
