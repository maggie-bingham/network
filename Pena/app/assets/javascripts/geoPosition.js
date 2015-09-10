window.onload = function() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
        var lat = position.coords.latitude;
        var lon = position.coords.longitude;
      });
    } else {
      document.write('Your browser does not support GeoLocation');
    }
}
