import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {
  const room_element = document.getElementById('room-id');
  const room_id = room_element.getAttribute('data-room-id');

  console.log(consumer.subscriptions)

  consumer.subscriptions.subscriptions.forEach((subscription) => {
    consumer.subscriptions.remove(subscription)
  })
  
  consumer.subscriptions.create({channel: "RoomChannel", room_id: room_id}, {
    connected() {
      console.log("connected to " + room_id)
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {

      const customer_element = document.getElementById('customer-id');
      const customer_id = Number(customer_element.getAttribute('data-customer-id'));

      let html;

      if (customer_id === data.post.customer_id) {
        html = data.mine
      } else {
        html = data.theirs
      }

      const messageContainer = document.getElementById('messages')
      messageContainer.innerHTML = messageContainer.innerHTML + html
    }
  });
})
