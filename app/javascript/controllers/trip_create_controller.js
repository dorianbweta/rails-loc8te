import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="trip-create"
export default class extends Controller {
  connect() {
  }

  create(event) {
    event.preventDefault();
    console.log(event);

    fetch(this.element.action, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.element)
    })
      .then(response => response.json())
      .then(data => {
        window.open(data.link_to_app, '_blank');
        window.location.href = data.redirect
      })
  }
}
