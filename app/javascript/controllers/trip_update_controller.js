import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="trip-update"
export default class extends Controller {
  static values = {
    link: String
  }
  connect() {
  }

  update(event) {
    event.preventDefault();
    console.log(event);
    window.open(this.linkValue, '_blank');

    fetch(this.element.action, {
      method: "PATCH",
      headers: { "Accept": "application/json" },
      body: new FormData(this.element)
    })
      .then(response => response.json())
      .then(data => window.location.href = data.redirect)
  }
}
