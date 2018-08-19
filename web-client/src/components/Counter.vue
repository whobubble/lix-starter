<template>
    <div>
        Counter {{name}}
        <button @click="dec">-</button>
        <input type="text" v-model="count" disabled />
        <button @click="inc">+</button>
    </div>
</template>

<script>
export default {
  props: ["channel", "name"],
  data: function() {
    return { count: 0 };
  },
  mounted: function() {
    this.channel.on("counter_get", response => {
      this.count = response.count;
    });
    this.channel.push("get");
  },
  methods: {
    dec: function() {
      this.channel.push("dec");
      this.channel.push("get");
    },
    inc: function() {
      this.channel.push("inc");
      this.channel.push("get");
    }
  }
};
</script>
