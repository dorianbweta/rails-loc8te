import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  static targets = ["map"]
  static values = {
    apiKey: String,
    startLocation: Array,
    endLocation: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.mapTarget,
      // Choose from Mapbox's core styles, or make your own style with Mapbox Studio
      style: 'mapbox://styles/mapbox/streets-v12',
      center: [-79.4512, 43.6568],
      zoom: 13
    });



    this.startPoint = this.startLocationValue
    this.endPoint = this.endLocationValue

    this.map.on('load', () => {
      this.getDirection()
    })
  }

  // generates the itinerary
  async getDirection() {
    const start = this.startPoint
    const end = this.endPoint
    const query = await fetch(
      `https://api.mapbox.com/directions/v5/mapbox/driving/${start[0]},${start[1]};${end[0]},${end[1]}?steps=true&geometries=geojson&access_token=${mapboxgl.accessToken}`,
      { method: 'GET' }
    );

    const json = await query.json();
    const data = json.routes[0];
    console.log(data);
    const route = data.geometry.coordinates;
    const geojson = {
      type: 'Feature',
      properties: {},
      geometry: {
        type: 'LineString',
        coordinates: route
      }
    };

    // if the route already exists on the map, we'll reset it using setData
    if (this.map.getSource('route')) {
      this.map.getSource('route').setData(geojson);
    }
    // otherwise, we'll make a new request
    else {
      this.map.addLayer({
        id: 'route',
        type: 'line',
        source: {
          type: 'geojson',
          data: geojson
        },
        layout: {
          'line-join': 'round',
          'line-cap': 'round'
        },
        paint: {
          'line-color': '#3887be',
          'line-width': 5,
          'line-opacity': 0.75
        }
      });
    }

    // Adjust the map bounds
   this.#fitMapToMarkers()

    // add turn instructions here at the end
    //this.#getInstructions(data)
  }

  // getRoute(){
  //   // get the params start location address
  //   // convert the address to long lat
  //   // save the long lat as this.startPoint

  //   // get the params end location address
  //   // convert the address to long lat
  //   // save the long lat as this.endPoint

  //   // run this.getDirection();

  //   const url = `https://api.mapbox.com/geocoding/v5/mapbox.places/${startAddress}.json?&access_token=${mapboxgl.accessToken}`
  //   fetch(url)
  //     .then(response => response.json())
  //     .then((data) => {
  //       console.log(data.features[0].center);
  //       this.startPoint = data.features[0].center
  //       this.endPoint = data.features[0].center

  //     })

  //   if (this.startPoint && this.endPoint) {
  //     this.getDirection();
  //   }
  // }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    const markers = [this.startPoint, this.endPoint]

    markers.forEach(marker => bounds.extend(marker))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 2000 })
  }
}
