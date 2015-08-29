import {Socket} from "deps/phoenix/web/static/js/phoenix"
import $ from "jquery"

let socket = new Socket("/socket")
let socketToken = $("meta[name='socket_token']").attr("content")

if (socketToken !== undefined) {
  socket.connect({token: socketToken})

  // Now that you are connected, you can join the lobby
  let channel = socket.channel("rooms:lobby", {})

  let messageInput = $("#message-input")

  messageInput.on("keypress", event => {
    if (event.keyCode === 13) {
      channel.push("new_message", {body: messageInput.val()})
      messageInput.val("")
    }
  })

  let messagesContainer = $("#messages")

  channel.on("new_message", payload => {
    messagesContainer.append(
      `<p>
        <span class="date-time">${Date()}</span>
        <span class="user-name">${payload.user.name}</span>
        ${payload.body}
       </p>`
    )
  })

  channel.join()
}

export default socket
