var phoenix = require("phoenix")
var socket = new phoenix.Socket("/socket", {
  params: {
    userToken:
      "oCu2cZMKj4g5/S7AILBlLhSSiXMR5yMGEO/fGmGbHoq1X3uDa1JUGRoHQaS0Tn1w"
  }
})
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

// var counter_channel = new_channel("simple", "user1")
// var counter_channel = new_channel("simple", "user2")
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

counter_channel.on("counter_inc", response => {
  console.log("Counter inc:", response.message)
})

counter_channel.on("counter_dec", response => {
  console.log("Counter dec:", response.message)
})

counter_channel.on("subscribers", response => {
  console.log("Subscribers: ", response)
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

function inc_counter(channel) {
  channel.push("inc").receive("error", response => {
    console.log("Unable to inc counter", response)
  })
}

function dec_counter(channel) {
  channel.push("dec").receive("error", response => {
    console.log("Unable to dec counter", response)
  })
}

function get_counter(channel) {
  channel
    .push("get")
    .receive("ok", response => {
      console.log("current counter is: ", response.count)
    })
    .receive("error", response => {
      console.log("Unable to get counter", response)
    })
}
