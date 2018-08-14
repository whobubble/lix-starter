var phoenix = require("phoenix")
var socket = new phoenix.Socket("/socket", {})
socket.connect()

function new_channel(subtopic, screen_name) {
  return socket.channel("counter:" + subtopic, { screen_name: screen_name })
}

function join(channel) {
  channel
    .join()
    .receive("ok", response => {
      console.log("Joined successfully!", response)
    })
    .receive("error", response => {
      console.log("Unable to join", response)
    })
}

var counter_channel = new_channel("simple", "user2")
join(counter_channel)

function leave(channel) {
  channel
    .leave()
    .receive("ok", response => {
      console.log("Left successfully!", response)
    })
    .receive("error", response => {
      console.log("Unable to leave", response)
    })
}

function say_hello(channel, greeting) {
  channel
    .push("hello", { message: greeting })
    .receive("ok", response => {
      console.log("Hello", response.message)
    })
    .receive("error", response => {
      console.log("Unable to say hello to the channel.", response.message)
    })
}

counter_channel.on("said_hello", response => {
  console.log("Returned Greeting:", response.message)
})

function new_counter(channel) {
  channel
    .push("new_counter")
    .receive("ok", response => {
      console.log("New Counter", response)
    })
    .receive("error", response => {
      console.log("Unable to start a new counter.", response)
    })
}
