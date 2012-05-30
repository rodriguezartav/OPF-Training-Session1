require('lib/setup')
Product = require('models/product')
Spine = require('spine')

class Item extends Spine.Controller
  tag: "li"
  className: "span3"

  events:
    "click .btn_remove_todo" : "onRemoveTodo"
    
  elements: 
    ".popable" : "popable"

  constructor: ->
    super
    Product.bind "change update" , @render
    @render()
    
  render: =>
    @popable.popover('hide')
    @html require("views/controllers/productBar/item")(@product)
    @popable.popover()
    

class ProductBar extends Spine.Controller
  className: ""

  elements:
    "input" : "txt_query"
    ".productos_list"  : "productos_list"

  events:
    "click .btn_add_todo" : "onAddTodo"
    "change .txt_query"   : "onChange"
    "click .search"       : "onClick"

  constructor: ->
    super
    Product.mock()
    @html require("views/controllers/productBar/layout")
    @productos_list.hide()

  onClick: (e) ->
    #HACK TO START RECEIVING UPDATE, USED SINCE SLIDE GOES 45MIN INTO SESSION
    Product.appStarted = true
    
    link = $(e.target)
    query = link.attr("data-query") 
    @txt_query.val query
    @search(query)

  onChange: (e) ->
    textbox = $(e.target)
    @search(textbox.val())

  search: (query) ->
    @productos_list.show()
    @productos_list.empty()
    productos = Product.filter query
    for product in productos
      @productos_list.append new Item(product: product).el


module.exports = ProductBar