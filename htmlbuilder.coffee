require './coreext'

class Builder
    constructor: (@io, @indent="  ")->
        @indent_level = 0
    write: (str)->
        @io.write(str)
    puts: (str) ->
        @write(@indent.repeat(@indent_level) + str + "\n")
    tag: (name, attrs, body)->
        if typeof attrs == 'object'
            attr_html = [" #{attr}=\"#{val}\"" for attr, val of attrs]
        else
            body = attrs
            attr_html = ""
        if body?
            @puts "<#{name}#{attr_html}>"
            @indent_level += 1
            if typeof body == 'function'
                body()
            else
                @puts body
            @indent_level -= 1
            @puts "</#{name}>"   
        else
            @puts "<#{name}#{attr_html} />"

build = (args..., func)->
    func.bind(new Builder(args...))()
    

HTML5_TAGS = [
    'a', 'abbr', 'address', 'area', 'article', 'aside', 'audio'
    'b', 'base', 'bdo', 'blockquote', 'body', 'br', 'button'
    'canvas', 'caption', 'cite', 'code', 'col', 'colgroup', 'command'
    'datalist', 'dd', 'del', 'details', 'dfn', 'div', 'dl', 'dt'
    'em', 'embded', 
    'fieldset', 'figcaption', 'figure', 'footer', 'form'
    'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'head', 'header', 'hgroup', 'hr', 'html',
    'i', 'iframe', 'img', 'input', 'ins'
    'keygen', 'kbd'
    'label', 'legend', 'li', 'link'
    'map', 'mark', 'menu', 'meta', 'meter'
    'nav', 'noscript'
    'object', 'ol', 'optgroup', 'option'
    'p', 'param', 'pre', 'progress'
    'q',
    'rq', 'rt', 'ruby'
    's', 'samp', 'script', 'section', 'select', 'small', 'source', 'span', 'strong', 'style', 'sub', 'summary', 'sup'
    'table', 'tbody', 'td', 'textarea', 'tfoot', 'th', 'thead', 'time','title', 'tr'
    'ul'
    'var'
    'video'
    'wbr'
]

for tag in HTML5_TAGS
    Builder::[tag] ?= Builder::tag.bind(tag)



exports.Builder = Builder
exports.build = build

# build process.stdout, ->
#     @html lang:'en',  =>
#         @body =>
#             @h1 'Hello World!'
#             @p 'This is a lovely building isn\'t it'
#             @p 'WHy yes it certainly seems to be.'
#             @p =>
#                 @puts "What is your name?"
#                 @input type:'text'
