$(function() {
  $("#terminal").terminal(function(command, term) {
    if (command == "") { return false }

    term.pause()

    let input = $("#input").value

    $.ajax({
      type: "POST",
      url: location.origin + "/command",
      data: { command: command, input: input },
      complete: function(res) {
        term.echo(res.responseText, {keepWords: true}).resume()
        $("#input").value = ""
      }
    })
  }, {
    prompt: "> ",
    greetings: "[[;lime;]Welcome.]",
    exit: false,
    historySize: false
  })
})
