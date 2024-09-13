document.addEventListener('turbolinks:load', () => {
    document.querySelectorAll('.delete-for-me-button').forEach(button => {
      button.addEventListener('click', (event) => {
        event.preventDefault();
        const messageId = event.target.dataset.messageId;
        const url = event.target.dataset.url;
  
        fetch(url, {
          method: 'POST',
          headers: {
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
            'Content-Type': 'application/json'
          },
          credentials: 'same-origin'
        })
        .then(response => response.json())
        .then(data => {
          if (data.success) {
            document.getElementById(`message-${messageId}`).remove();
          } else {
            console.error('Failed to delete message:', data.error);
          }
        })
        .catch(error => console.error('Error:', error));
      });
    });
  });