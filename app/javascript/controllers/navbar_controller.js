import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ["burger", "nav"]

  openMenu(e) {
    this.burgerTarget.classList.toggle('is-open');
    this.navTarget.classList.toggle('is-open');
  }
}
