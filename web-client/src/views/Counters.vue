<template>
  <div class="counters">
    <h1>This is a page with counters</h1>
    <input type="text" ref="counter_name" />
    <button @click="create_counter">New Counter</button>
    <div v-for="(channel, name) in counters"
         :key="name">
      <span><Counter :channel="channel" :name="name" /></span>
    </div>
  </div>
</template>

<script>
import Counter from "@/components/Counter.vue";

export default {
  name: "Counters",
  components: { Counter },
  data: function() {
    return { counters: {} };
  },
  methods: {
    create_counter() {
      console.log(this.counters);
      let name = this.$refs.counter_name.value;
      if (name) {
        let channel = this.$socket.channel("counter:" + name, {
          screen_name: "user1"
        });
        channel
          .join()
          .receive("ok", resp => {
            console.log("Counter Joined successfully", resp);
          })
          .receive("error", resp => {
            console.log("Counter Unable to join", resp);
          });
        channel.push("new_counter");
        this.$set(this.counters, name, channel);
      }
    }
  }
};
</script>
