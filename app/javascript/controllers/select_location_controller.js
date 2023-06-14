import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="select-location"
export default class extends Controller {
  static targets = ["start", "end"]

  connect() {
  }

  updateInput(event) {
    const address = event.currentTarget.dataset.address;

    if (this.input.ariaLabel === "Pickup Point") {
      this.startTarget.value = address;
    } else {
      this.endTarget.value = address;
    }

    this.input.value = address;
    event.currentTarget.classList.add("active")
  }

  setFocusedInput({ detail }) {
    console.dir(detail);
    this.input = detail;
  }
}
