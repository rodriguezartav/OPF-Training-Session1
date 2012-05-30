require('lib/setup')
Todo = require('models/todo')
Spine = require('spine')

class Item extends Spine.Controller
  tag: "li"
  className: "well"

  events:
    "click .btn_remove_todo" : "onRemoveTodo"
    "click .name"           : "onClick"
    
  constructor: ->
    super
    @html require("views/controllers/todo/item")(@todo)

  onClick: (e) =>
    target = $(e.target)
    target.html "<s>#{target.html()}</s>"

  onRemoveTodo: =>
    @todo.destroy()
    @release()

class Todos extends Spine.Controller
  className: "content span9"

  elements:
    "input" : "txt_todo"
    ".list"  : "todoList"

  events:
    "click .btn_add_todo" : "onAddTodo"

  constructor: ->
    super
    Todo.fetch()
    @html require("views/controllers/todo/layout")

  onAddTodo: (e) =>
    return false if @txt_todo.val().length == 0
    todo = Todo.create { name: @txt_todo.val()  }
    @txt_todo.val ""
    item = new Item( todo: todo)
    @todoList.append item.el

module.exports = Todos