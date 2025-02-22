import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  static targets=["form","button"]

  like_post() { 
    this.buttonTarget.textContent = "Liking.."
  }

  unlike_post() {
    this.element.textContent="Unliking.."
  }

}
