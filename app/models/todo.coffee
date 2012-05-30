Spine = require('spine')

class Todo extends Spine.Model
  @configure "Todo" , "name" , "completed"

  @extend Spine.Model.Local

module.exports = Todo

