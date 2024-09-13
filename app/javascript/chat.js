import consumer from "./channels/consumer"

document.addEventListener('turbolinks:load', () => {
  const chatContainer = document.getElementById('chat-messages');
  
  if (chatContainer) {
    const chatId = chatContainer.dataset.chatId;

    consumer.subscriptions.create({ channel: "ChatChannel", chat_id: chatId }, {
      received(data) {
        switch(data.action) {
          case 'new_message':
            this.appendMessage(data.message);
            break;
          case 'delete_message':
            this.removeMessage(data.message_id);
            break;
        }
      },

      appendMessage(message) {
        chatContainer.insertAdjacentHTML('beforeend', message);
        chatContainer.scrollTop = chatContainer.scrollHeight;
      },

      removeMessage(messageId) {
        const messageElement = document.getElementById(`message_${messageId}`);
        if (messageElement) messageElement.remove();
      }
    });

    chatContainer.addEventListener('click', (event) => {
      if (event.target.classList.contains('delete-for-everyone')) {
        const messageId = event.target.dataset.messageId;
        this.deleteForEveryone(messageId);
      } else if (event.target.classList.contains('delete-for-me')) {
        const messageId = event.target.dataset.messageId;
        this.deleteForMe(messageId);
      }
    });
  }

  deleteForEveryone(messageId) {
    fetch(`/messages/${messageId}`, {
      method: 'DELETE',
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
      },
    }).then(response => {
      if (response.ok) {
        this.removeMessage(messageId);
      }
    });
  }

  deleteForMe(messageId) {
    fetch(`/messages/${messageId}/delete_for_me`, {
      method: 'DELETE',
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
      },
    }).then(response => {
      if (response.ok) {
        this.removeMessage(messageId);
      }
    });
  }

  removeMessage(messageId) {
    const messageElement = document.getElementById(`message_${messageId}`);
    if (messageElement) messageElement.remove();
  }
});