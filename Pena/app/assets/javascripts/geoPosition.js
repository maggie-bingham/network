window.onload = function() {
    if ((navigator.geolocation) && ($('body').attr('id') != undefined)) {
      navigator.geolocation.getCurrentPosition(function(position) {
        var lat = position.coords.latitude;
        var lon = position.coords.longitude;
        $.ajax({
          method: "PUT",
          url: "user/" + $('body').attr('id').substr(5),
          data: {'user' : { 'lat' : lat, 'lon' : lon}}
        })
      });
    } else {
      document.write('Your browser does not support GeoLocation');
    }
}
