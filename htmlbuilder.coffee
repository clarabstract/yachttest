require './coreext'

class Builder
    constructor: (@io)->
    write: (str)->
        @io.write(str)
    puts: (str) ->
        @write(str + "\n")
    tag: (name, attrs)->
        attr_html = [" #{attr}=\"#{val}\"" for attr, val of attrs]
        @puts "<#{name}#{attr_html} />"


Builder::html = Builder::tag.partial('html')



exports.Builder = Builder

b = new Builder(process.stdout)
    
b.html(lang:'en')
