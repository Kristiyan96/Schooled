const { environment } = require('@rails/webpacker')
const vue =  require('./loaders/vue')
const coffee =  require('./loaders/coffee')

environment.loaders.append('coffee', coffee)
environment.loaders.append('vue', vue)
module.exports = environment
