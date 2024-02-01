// There is no way to protect the key from maptiler.
const key = "mC2VeBGZQ9vvKUyiRNmL";
const map = L.map('map').setView([60.137451890638886, 68.13734351262877], 4); //starting position
L.tileLayer(`https://api.maptiler.com/maps/streets-v2/{z}/{x}/{y}.png?key=${key}`,{ //style URL
  tileSize: 512,
  zoomOffset: -1,
  minZoom: 1,
  attribution: "\u003ca href=\"https://www.maptiler.com/copyright/\" target=\"_blank\"\u003e\u0026copy; MapTiler\u003c/a\u003e \u003ca href=\"https://www.openstreetmap.org/copyright\" target=\"_blank\"\u003e\u0026copy; OpenStreetMap contributors\u003c/a\u003e",
  crossOrigin: true
}).addTo(map);

const mapElement = document.getElementById('map');
const dataJSON = JSON.parse(mapElement.getAttribute('data-geom'));

dataJSON.forEach((data) => {
  L.geoJSON({
    'type': 'Feature',
    'geometry': {
      'type': 'Polygon',
      'coordinates': data
    }
  }, {
    style: {
      color: "rgb(195,44,0)",
      opacity: 0.8,
      fillColor: "rgb(195,44,0)",
      fillOpacity: 0.8
    }
  }).addTo(map);
})

