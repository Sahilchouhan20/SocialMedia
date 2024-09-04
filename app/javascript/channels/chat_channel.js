import consumer from "./consumer";

const chatId = document.getElementById('messages').dataset.chatId;

consumer.subscriptions.create({ channel: "ChatChannel", chat_id: chatId }, {
  received(data) {
    const messagesElement = document.getElementById('messages');
    messagesElement.innerHTML += `<div><strong>${data.user}:</strong> ${data.content}</div>`;
  }
});
