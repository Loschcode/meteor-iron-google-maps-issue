# 
# Variables
# 
@MAP_ZOOM = Meteor.settings.public.MAP_ZOOM

#
# Events
#
Template.GeoMap.events {}

#
# Helpers
#
Template.GeoMap.helpers {

  geolocationError: =>

    error = Geolocation.error()
    return error and error.message

  mapOptions: =>

    latLng = Geolocation.latLng()

    if (Meteor.isCordova)
      alert(GoogleMaps.loaded())

    # Initialize the map once we have the latLng.
    if GoogleMaps.loaded() and latLng
      
      if (Meteor.isCordova)
        alert('GoogleMaps.loaded')

      return {
        center: new google.maps.LatLng(latLng.lat, latLng.lng)
        zoom: @MAP_ZOOM
      }

}

#
# onCreated
#
Template.GeoMap.onCreated =>

  GoogleMaps.load()

  if (Meteor.isCordova)
    alert('GoogleMaps.load')

  # When it's ready, we process the position
  GoogleMaps.ready 'geoMap', (map) =>

    if (Meteor.isCordova)
      alert('GoogleMaps.ready')

    marker = undefined

    # Create and move the marker when latLng changes.
    Tracker.autorun =>

      # LatLng
      latLng = Geolocation.latLng()

      if !latLng
        return

      # If the marker doesn't yet exist, create it.
      if !marker

        marker = new google.maps.Marker
          position: new google.maps.LatLng(latLng.lat, latLng.lng)
          map: map.instance

      else

        marker.setPosition latLng

      # Center and zoom the map view onto the current position.
      map.instance.setCenter marker.getPosition()
      #map.instance.setZoom @MAP_ZOOM only if we want to always zoom at the same

#
# onRendered
#
Template.GeoMap.onRendered ->

#
# onDestroyed
#
Template.GeoMap.onDestroyed ->