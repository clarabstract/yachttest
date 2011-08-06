class Resource
    @singular = () -> this.name.toLowerCase()
    @plural = () -> @singular() + 's'


exports.Resource = Resource
