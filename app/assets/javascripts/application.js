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
//= require jquery.datetimepicker
//= require_tree .

// **********************************************************************
// order total calculation

var myCalc = myCalc || {};

myCalc.initialize = function() {

  // set up variables
  myCalc.priceElement = $("#hiddenprice");
  myCalc.quantityElement = $("#order_quantity");
  myCalc.totalElement = $("#totalshow");

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

// **********************************************************************
// mobile meals

var mobSpace = mobSpace || {};

mobSpace.initialize = function() {

  mobSpace.searchForm = $('#search_form');
  mobSpace.latitudeElement = $("#latitude");
  mobSpace.longitudeElement = $("#longitude");
  mobSpace.nameElement = $('#search');
  mobSpace.categoryElement = $('select');
  mobSpace.searchElement = $("#searchbutton");
  mobSpace.mealList = $('#meal_list');
  mobSpace.loadingElement = $('#loadingDiv');

  // on initialize, geolocate then run updateMeals
  var geolocation = navigator.geolocation.getCurrentPosition(mobSpace.updateMeals);

  // on click, geolocate then run updateMeals
  mobSpace.searchElement.on('click', function(){
    mobSpace.searchForm.submit();
    mobSpace.loadingElement.show();
  });

  // handle ajax responses (associated with remote: true form option)
  mobSpace.searchForm.
  on('ajax:success', function(evt, data, status, xhr){
    mobSpace.mealList.html(data);
    mobSpace.loadingElement.hide();
  }).
  on('ajax:error', function(xhr, status, error){
    console.log('error! :', error);
  });
  
  // submit the form while typing in meal name field
  mobSpace.nameElement.on('keyup', function(){
    mobSpace.searchForm.submit();
  })

  // submit the form when a new category is selected
  mobSpace.categoryElement.on('change', function(){
    mobSpace.searchForm.submit();
  })

};

mobSpace.updateMeals = function(position){

  // get user position
  var latitude = position.coords.latitude;
  var longitude = position.coords.longitude;

  // submit the form if the user's location is substantially different from what was being used already
  mobSpace.latitudeElement.val(latitude);
  mobSpace.longitudeElement.val(longitude);
  mobSpace.searchForm.submit();    
  
};

// **********************************************************************
// desktop meals

var deskSpace = deskSpace || {};

deskSpace.latitude  = 51.52;
deskSpace.longitude = -1.115;

deskSpace.initialize = function() {

  deskSpace.nameElement = $('#search');
  deskSpace.categoryElement = $('select');
  deskSpace.searchElement = $("#searchbutton");
  deskSpace.mapElement = $("#desktop_meals")[0];
  deskSpace.loadingElement = $('#loadingDiv');

  // set default center point and load map

  var mapOptions = { center: { lat: deskSpace.latitude, lng: deskSpace.longitude }, zoom: 11  };

  deskSpace.map = new google.maps.Map(deskSpace.mapElement, mapOptions);

  // set up empty array of markers
  deskSpace.markers = [];

  // on initialize, geolocate then run centerMap and findMeals
  var geolocation = navigator.geolocation.getCurrentPosition(deskSpace.centerMap);
  
  // on click, geolocate then run centerAndFindMeals
  deskSpace.searchElement.on('click', function(){
    deskSpace.loadingElement.show();
    deskSpace.findMeals();
  });

};

deskSpace.centerMap = function(position){

  // get user position, create dummy marker and center map to dummy marker
  deskSpace.latitude = position.coords.latitude;
  deskSpace.longitude = position.coords.longitude;

  var icon2 = {
    url: "http://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Blue_sphere.svg/150px-Blue_sphere.svg.png",
    scaledSize: new google.maps.Size(20, 20),
    origin: new google.maps.Point(0,0), //origin
    anchor: new google.maps.Point(20, 20)
  }





  var markerCenter = new google.maps.Marker({ position: {lat: deskSpace.latitude, lng: deskSpace.longitude}, icon: icon2 });
  markerCenter.setMap(deskSpace.map);
  deskSpace.map.setCenter(markerCenter.getPosition());


  deskSpace.findMeals();
};

deskSpace.findMeals = function(){
  
  // // get form inputs and create data hash
  var name = deskSpace.nameElement.val();
  var category = deskSpace.categoryElement.val();
  var data = { latitude: deskSpace.latitude, longitude: deskSpace.longitude, search: name, category: { category_id: category } };

  // send data hash to meals controller
  $.ajax({
    type: "GET",
    url: "/meals",
    data: data,
    dataType: 'json',
    success: function(response){
      deskSpace.renderMeals(response);
    }
  });

};

deskSpace.renderMeals = function(response){
  var meals = response.meals;

  // clear map and empty array of markers
  deskSpace.drawMap(null);
  deskSpace.markers = [];

  var icon = {
    url: "http://www.juniata.edu/life/i/redesign/dining/diningicon.png",
    scaledSize: new google.maps.Size(60, 60),
    origin: new google.maps.Point(0,0), //origin
    anchor: new google.maps.Point(20, 20)
  }

  // for each meal, add to array of markers and create popup
  meals.forEach(function(meal){
    var marker = new google.maps.Marker({ position: {lat: meal.latitude, lng: meal.longitude}, icon: icon });
    // add to array of markers
    deskSpace.markers.push(marker);
    deskSpace.popup = new google.maps.InfoWindow();
    google.maps.event.addListener(marker, 'click', function(){
      deskSpace.popup.close();
      deskSpace.popup.setContent("<div id='popupcontent'><a href='" + meal.url + "'><strong>" + meal.name + "</strong><br/>" + meal.price_text + "<br/>" + meal.distance_text + "</a></div>");
      deskSpace.popup.open(deskSpace.map, marker);
    });
  });

  // draw map
  deskSpace.drawMap(deskSpace.map);
  deskSpace.loadingElement.hide();

}

deskSpace.drawMap = function(map) {
  for (var i = 0; i < deskSpace.markers.length; i++) {
    deskSpace.markers[i].setMap(map);
  }
}

// **********************************************************************

$(function(){
  // add datetimepicker
  $('.datetimepicker').datetimepicker({
    format:'d.m.Y H:i',
    minDate: 0

  });

  $('.datepicker').datetimepicker({
    timepicker:false,
    minDate: 0
  });

  //hamburger-icon display
  $('.nav-icon').on('click', function(e){
    e.preventDefault();
    $('nav ul').slideToggle();
  });

  if ($('#desktop_meals').length > 0) {
    deskSpace.initialize();
  } else {
    mobSpace.initialize();
  }

  myCalc.initialize();


});



  

