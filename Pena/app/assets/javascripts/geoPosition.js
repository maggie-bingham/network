<<<<<<< HEAD
var elMap = document.getElementById('loc');
var msg = 'Sorry';

if (navigator.geolocation) {
  navigator.geolocation.getCurrentPosition(success,fail);
  elMap.textContent = 'Checking Location';
} else {
  elMap.textContent = msg;
}

function success (position) {
  msg = '<h3>Longtitude:<br>';
  msg += position.coords.longitude + '</h3>';
  msg += '<h3>Latitude:<br>';
  msg += position.coords.latitude + '</h3>';
  elMap.innerHTML = msg;
}

function fail(msg) {
  elMap.textContent = msg;
  console.log(msg.code);
=======
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
>>>>>>> 75f40ce3a562a1927dcdf740105402f6d47f0a1c
}
