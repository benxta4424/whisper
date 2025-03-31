import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clear-comms"
export default class extends Controller {
  clear() {
    this.element.reset()
  }
}
