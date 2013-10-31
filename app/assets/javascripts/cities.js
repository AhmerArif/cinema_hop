var CityController = Paloma.controller('City');

// Executes when Rails City#index is executed.
CityController.prototype.index = function()
{

   function lookup_location() {
     geoPosition.getCurrentPosition(show_map, show_map_error);
   }
   function show_map(loc) {
     codeLatLng(loc.coords.latitude,loc.coords.longitude);
   }
   function show_map_error() {
     $("#live-geolocation").html('Unable to determine your location.');
   }

   var geocoder;

   if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(successFunction, errorFunction);
   }
   //Get the latitude and the longitude;
   function successFunction(position) {
       var lat = position.coords.latitude;
       var lng = position.coords.longitude;
       codeLatLng(lat, lng);
   }

   function errorFunction(){
       console.log("Geocoder failed");
   }

     function codeLatLng(lat, lng) {
       geocoder = new google.maps.Geocoder();
       var latlng = new google.maps.LatLng(lat, lng);
       geocoder.geocode({'latLng': latlng}, function(results, status) {
         if (status == google.maps.GeocoderStatus.OK) {
           if (results[1]) {
            //formatted address
            console.log(results[0].formatted_address);
           //find country name
                for (var i=0; i<results[0].address_components.length; i++) {
               for (var b=0;b<results[0].address_components[i].types.length;b++) {

               //there are different types that might hold a city admin_area_lvl_1 usually does in come cases looking for sublocality type will be more appropriate
                   if (results[0].address_components[i].types[b] == "administrative_area_level_2") {
                       city= results[0].address_components[i];
                       break;
                   }
               }
           }
          var city_link_id = city.short_name.split(' ')[0];

          $(".city_navlinks").each(function( href ) {
            if (this.id == city_link_id){
              window.location.href = this.href;
            }
          });

          console.log("Your in: " + city.short_name.split(' ')[0] + " which isn't supported");

           } else {
             console.log("No results found");
           }
         } else {
           console.log("Geocoder failed due to: " + status);
         }
       });
     }
};