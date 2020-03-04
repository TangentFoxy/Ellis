import Widget from require "lapis.html"

class extends Widget
  content: =>
    div class: "container", ->
      div class: "row", ->
        div class: "col", ->
          div id: "terminal"
          textarea id: "input"
        div class: "col", ->
          div id: "output"
    script src: "static/js/jquery/jquery.terminal-2.14.1.min.js"
    link rel: "stylesheet", href: "static/js/jquery/jquery.terminal-2.14.1.min.css"
    script src: "static/js/terminal.js"
    link rel: "stylesheet", href: "static/css/style.css"
