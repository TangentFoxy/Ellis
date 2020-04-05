lapis = require "lapis"
config = require("lapis.config").get!

class extends lapis.Application
  "/console": =>
    if config and config.console and config.console != "false"
      require("lapis.console").make(env: "all")(@)

  layout: "layout"
  @include "commands"

  handle_error: (err, trace) =>
    return layout: false, status: 500, "[[;red;]#{err\gsub "]", "\\]"}\n#{trace\gsub "]", "\\]"}]"

  [terminal: "/terminal"]: => render: true
