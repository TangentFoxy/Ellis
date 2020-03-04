lapis = require "lapis"

class extends lapis.Application
  layout: "layout"
  @include "commands"

  handle_error: (err, trace) =>
    return layout: false, status: 500, "[[;red;]#{err\gsub "]", "\\]"}\n#{trace\gsub "]", "\\]"}]"

  [terminal: "/terminal"]: => render: true
