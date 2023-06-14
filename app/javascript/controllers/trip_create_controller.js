import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="trip-create"
export default class extends Controller {
  static values = { user: Boolean }

  connect() {
  }

  create(event) {
    console.log(this.userValue);

    if (this.userValue) {
      event.preventDefault();

      fetch(this.element.action, {
        method: "POST",
        headers: { "Accept": "application/json" },
        body: new FormData(this.element)
      })
        .then(response => response.json())
        .then(data => {
          console.log(data);
          window.open(data.link_to_app, '_blank');
          window.location.href = data.redirect
        })
    }
  }
}
