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
      headers: { "Accept": "application/json" }, // telling the server we’re sending some JSON
      body: new FormData(this.element) // with the actual JSON being posted
    })
    // You need to parse the response with .json()
      .then(response => response.json())
    // `data` is now a JS object
      .then(data => {
        window.open(data.link_to_app, '_blank');
        window.location.href = data.redirect
      })
  }
}
