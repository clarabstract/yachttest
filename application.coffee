class Application
    constructor: (@name) ->
        @resources = []
    register_resources: (modules...) ->
        new_resources = []
        for module in modules
            if typeof module is 'string'
                module = require(module)
            for name, klass of module
                new_resources.push(klass)
        @resources = @resources.concat(new_resources)
        return new_resources

exports.Application = Application