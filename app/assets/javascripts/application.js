// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

// order total calculation

var myCalc = myCalc || {};

myCalc.initialize = function() {
  var price = parseFloat(myCalc.priceElement.text());
  myCalc.quantityElement.on("change", function() {
    myCalc.recalculateTotal([price]);
  });
};
// TODO check whether price about needs to be in square brackets? "([price])"

myCalc.recalculateTotal = function(price) {
  var quantity = myCalc.quantityElement.val();
  var total = price * quantity;
  myCalc.totalElement.text("£" + total.toFixed(2));
};

$(function(){
  myCalc.priceElement = $("#hiddenprice");
  myCalc.quantityElement = $("#order_quantity");
  myCalc.totalElement = $("#totalshow");
  myCalc.initialize();
});


// ajax meal index

var myMeals = myMeals || {};

$(function(){

  $('#search_form').
  on('ajax:success', function(evt, data, status, xhr){
    $('#meal_list').html(data);
  }).
  on('ajax:error', function(xhr, status, error){
    console.log('error! :', error);
  });
  
  $('#search').on('keyup', function(){
    $('#search_form').submit();
  })
  

});

// mapping

var myMap = myMap || {};

myMap.initialize = function() {
  
  
  var mapOptions = {
    center: {lat: 51.52, lng: -0.115},
    zoom: 14,
    styles: [
      {
        "stylers": [
          { "lightness": 14 },
          { "gamma": 0.59 },
          { "saturation": -71 }
        ]
      }
    ]
  
  };

  myMap.map = new google.maps.Map(myMap.mapElement, mapOptions);


  




  myMap.locatorElement.on('click', function(){
    myMap.getPosition();
    console.log("clicked");
  });
};

myMap.getPosition = function(){
  if (navigator.geolocation) {
    var geolocation = navigator.geolocation.getCurrentPosition(myMap.geolocationSuccess, myMap.geolocationFail);
    console.log("geolocated")
  } else {
    alert("Geolocation not enabled.");
  };
};

myMap.geolocationSuccess = function(position){
  var latitude = position.coords.latitude;
  var longitude = position.coords.longitude;
  // var data = { latitude: latitude, longitude: longitude };
  myMap.latitudeElement.val(latitude);
  myMap.longitudeElement.val(longitude);
  console.log("form updated");

  var markerOptions = {
    position: {lat: latitude, lng: longitude}
  };

  var marker = new google.maps.Marker(markerOptions);
  marker.setMap(myMap.map);


  var popupOptions = {
    content: "you are here",
  };

  var popup = new google.maps.InfoWindow(popupOptions);

  google.maps.event.addListener(marker, 'click', function(){
    popup.open(myMap.map, marker);
  });

  myMap.map.setCenter(marker.getPosition());

};

// myMap.submitAjax = function(data){
//   console.log("sending ajax");
//   console.log(data);
//   $.ajax({
//     type: "GET",
//     url: "/meals",
//     data: data,
//     dataType: 'json',
//     success: function(response){
//       console.log("success");
//       console.log(response);
//       // updateBalance('#current_balance', response["current_balance"]);
//       // updateBalance('#savings_balance', response["savings_balance"]);
//     }
//   });
// };

myMap.geolocationFail = function(){
  alert("Geolocation failed.")
};

$(function(){
  myMap.locatorElement = $("#locator");
  myMap.latitudeElement = $("#latitude");
  myMap.longitudeElement = $("#longitude");
  myMap.finderElement = $("#finder");
  myMap.mapElement = $("#desktop_meals")[0];
  console.log(myMap.mapElement);
  myMap.initialize();
});


//hamburger-icon display
$(document).ready(function(){
  $('.nav-icon').on('click', function(e){
    e.preventDefault();
    $('nav ul li').slideToggle();
  });
});






