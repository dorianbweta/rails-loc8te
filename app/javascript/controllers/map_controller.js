import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  static values = { apiKey: String }
  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    const map = new mapboxgl.Map({
      container: this.element,
      // Choose from Mapbox's core styles, or make your own style with Mapbox Studio
      style: 'mapbox://styles/mapbox/streets-v12',
      center: [-79.4512, 43.6568],
      zoom: 13
    });

    // map.addControl(
    //     new MapboxDirections({
    //         accessToken: mapboxgl.accessToken
    //     }),
    //     'top-left'
    // );
  }

}
