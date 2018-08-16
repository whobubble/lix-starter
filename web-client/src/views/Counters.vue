<template>
  <div class="counters">
    <h1>This is a page with counters</h1>
  </div>
</template>

<script>
import { Socket } from "phoenix-socket";

export default {
  name: "Counters",
  mounted() {
    let socket = new Socket("ws://localhost:4000/socket");
    socket.connect();
    let channel = socket.channel("counter:simple", {
      screen_name: "user3"
    });
    channel
      .join()
      .receive("ok", resp => {
        console.log("Counter Joined successfully", resp);
      })
      .receive("error", resp => {
        console.log("Counter Unable to join", resp);
      });
  }
};
</script>
