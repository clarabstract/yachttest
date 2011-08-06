###
resource routing!
singulars|plurals

/singular/pk/members|

###
class Router
    constructor: () ->
        @routers = []
    add_router: (router) ->
        @routers.push(router)
    compile: (prefix='') ->
        regexp = for index, router of @routers
            "(?P<#{prefix+index}>#{router.compile(index)})"

class ResourceRouter
    constructor: (@resource) ->
    compile: (index) ->
        @resource.singular() + "/"
  
route = (application) ->
    application.root_router = new Router()
    application._original_register_resources = application.register_resources
    wrap application, 'register_resources', ($original, args...) ->
        new_resources = $original(args...)
        for resource in new_resources
            application.root_router.add_router(new ResourceRouter(resource))
        return new_resources

exports.route = route