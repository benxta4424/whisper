import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
    after_click() {
    this.element.textContent = "Liked"
  }
}
