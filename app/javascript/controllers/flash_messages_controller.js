import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash-messages"
export default class extends Controller {
  connect() {
    this.hideMessagesAfterDelay()
  }

  hideMessagesAfterDelay() {
    const frames = document.querySelectorAll("[data-turbo-frame='flash-frame']")
    frames.forEach((frame) => {
      setTimeout(() => {
        frame.parentNode.removeChild(frame)
      }, 5000) // Adjust the delay (in milliseconds) as needed
    })
  }
}
