String::repeat = (times) ->
	new Array( times + 1 ).join( this )
	
global.wrap = (object, property, wrapper) ->
    $original = object[property].bind(object)
    object[property] = (args...) ->
        return wrapper($original, args...)
    