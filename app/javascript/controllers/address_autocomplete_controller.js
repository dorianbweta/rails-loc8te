import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static values = { apiKey: String }
  static targets = ["location"]

  connect() {
    let placeholder = ""
    if (this.locationTarget.id === "trip_start_location") {
      placeholder =  "Pickup Point"
    } else {
      placeholder =  "Destination"
    }

    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "country,region,place,postcode,locality,neighborhood,address,poi",
      placeholder: placeholder
    })
    this.geocoder.addTo(this.element)
    this.geocoder.on("result", event => this.setInputValue(event))
    this.geocoder.on("clear", () => this.#clearInputValue())

    console.dir(this.geocoder.container.children[1]);
    const input = this.geocoder.container.children[1]
    input.addEventListener("focus", (event) => this.passFocusedInput(event))
  }

  passFocusedInput(event) {
    this.dispatch("passFocusedInput", { detail: event.currentTarget })
  }

  setInputValue(event) {
    console.log("hello")
    const selectedPlace = event.result.place_name
    this.locationTarget.value = selectedPlace
    this.dispatch("setInputValue", { detail: { content: selectedPlace, id: this.locationTarget.id } })
  }

  #clearInputValue() {
    this.locationTarget.value = ""
  }

  disconnect() {
    this.geocoder.onRemove()
  }
}
