require('lib/setup')
Spine = require('spine')
Product = require("models/product")
Todos = require('controllers/todos')
ProductBar = require('controllers/productBar')
SocketManager = require('lib/socketManager')

class App extends Spine.Controller

  elements:
    "#impress" : "impress"
    ".todo"    : "todo"

  constructor: ->
    super
    new SocketManager()
    @render(@impress)
    prettyPrint()
    new Todos(el: $("#todo .canvas"))
    new ProductBar(el: $("#productBar .canvas"))
    impress().init()

  render: (el) ->
     content = $('<div/>')
     content.append @appendSlide "views/slides/step1_splash"           , 0       , 0      , 9  , 0  , true
     
     content.append @appendSlide "views/slides/step2_singlePage"         , 0       , 7900      , 9  , 0  
     content.append @appendSlide "views/slides/step3_async"            , 13000   , 0      , 9  , 0  

     content.append @appendSlide "views/slides/step2_realtime"         , 0       , 7900      , 9  , 0  
     content.append @appendSlide "views/slides/step3_realtime"         , 13000   , 0      , 9  , 0  

     
     content.append @appendSlide "views/slides/step2_server"         , 0       , 7900      , 9  , 0   
     content.append @appendSlide "views/slides/step3_opf"              , 13000   , 0      , 9  , 0  

     content.append @appendSlide "views/slides/step2_stats"            , 0       , 7900      , 9  , 0  

     content.append @appendSlide "views/slides/step4_me"               , 0       , 3600      , 1  , 0  
     
     
     content.append @appendSlide "views/slides/step5_opf"              , 0       , 700      , 1  , 0  

     content.append @appendSlide "views/slides/step5_nacion"           , 0       , 1000      , 1  , 90  
     
     content.append @appendSlide "views/slides/step6_anatomyHttp"      , -3000   , 7800      , 9  , 0  
     content.append @appendSlide "views/slides/step6_anatomy"          , 7000   , 0      , 9  , 0  
     content.append @appendSlide "views/slides/step6_mvc"              ,  10000   , 0      , 9  , 0  
     
     content.append @appendSlide "views/slides/step6_spine"            ,  13000   , -900      , 9  , 0  
     
     
     content.append @appendSlide "views/slides/step6_todo"             ,  10000   , 900      , 9  , 0  

     content.append @appendSlide "views/slides/step6_model"            ,  9000   , -6000      , 9  , 0  
     content.append @appendSlide "views/slides/step6_view"             ,  0      , 7000      , 9  , 0  
     content.append @appendSlide "views/slides/step6_controller"       , 0       , 9000      , 9  , 0  
     content.append @appendSlide "views/slides/step6_controllerItem"       , 0       , 9000      , 9  , 0  


     content.append @appendSlide "views/slides/step6_container"        ,  10000   , -6000      , 9  , 0  
     
     content.append @appendSlide "views/slides/step7_opf"              , -10000    , 20500      , 5  , 180  
     content.append @appendSlide "views/slides/step7_spineApp"         , -2200     , -3900      , 5  , 180  
     content.append @appendSlide "views/slides/step7_directory"        , -2200     , -3900      , 5  , 180  
     content.append @appendSlide "views/slides/step7_package"          , -3000     , -3000     , 5  , 180  
     content.append @appendSlide "views/slides/step7_parts"            , -3000     , -3000       , 5  , 180  
     
     
     content.append @appendSlide "views/slides/step8_splash"          , 0  , 6500   , 4  , 0  
     content.append @appendSlide "views/slides/step8_anatomy"         , 0  , 2800   , 4  , 0  
     content.append @appendSlide "views/slides/step8_model"           , 0  , 4500   , 4  , 0  
     content.append @appendSlide "views/slides/step8_view"            , 0  , 4500   , 4  , 0  
     content.append @appendSlide "views/slides/step8_view2"            , 0  , 4500   , 4  , 0  
     content.append @appendSlide "views/slides/step8_controller"      , 0  , 4500   , 4  , 0  
     content.append @appendSlide "views/slides/step8_controllerItem"      , 0  , 4500   , 4  , 0  
     content.append @appendSlide "views/slides/step8_socket"          , 0  , 4500   , 4  , 0  

     content.append @appendSlide "views/slides/step9"          , 0  , 4500   , 1  , 0  


     el.html content

   appendSlide: (slide,x,y,scale=1 , rotate=0 , absolute=false)  =>
     options = x:x , y:y , scale:scale , rotate:rotate
     @updateOptions(options) if !absolute
     html = require(slide)(options)
     @getOptions(html)
     return html

   updateOptions: (options) =>
     options.x += parseFloat @lastOptions.x
     options.y += parseFloat(@lastOptions.y)

   getOptions: (html) =>
     html = $(html)
     @lastOptions =
       x: html.attr("data-x")
       y: html.attr("data-y")
       scale: html.attr("data-scale")
       rotate: html.attr("data-rotate")


module.exports = App
    