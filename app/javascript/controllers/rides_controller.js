import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="rides"
export default class extends Controller {
  static targets = ["infobox"]
  connect() {
    console.log("hellofrom ridessssss")
  }

  updateBackground(event) {
    this.infoboxTargets.forEach((box) => {
      box.classList.remove("bg-red")
      box.classList.add("bg-whitesmoke")
    })
    event.currentTarget.classList.remove("bg-whitesmoke")
    event.currentTarget.classList.add("bg-red")
  }
}
