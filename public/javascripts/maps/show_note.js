
$(document).ready(function(){	
	var map = new L.Map('map');
	
	var cloudmade = new L.TileLayer('http://{s}.tile.cloudmade.com/c827a0eab8d845a6b31a791809e49933/997/256/{z}/{x}/{y}.png', {
	    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
	    maxZoom: 18
	});
	var london = new L.LatLng(51.505, -0.09); // geographical point (longitude and latitude)
	var montreal = new L.LatLng(45.515, -73.58)
	map.setView(montreal,14).addLayer(cloudmade);
	if (gon.note) {
		map.setView(new L.LatLng(gon.note.latitude, gon.note.longitude), 14).addLayer(cloudmade);
		setMarker(gon.note);
	}
	
	if (gon.notes.length > 0) {
		map.addLayer(cloudmade);
		var i;
		var array = [];
		for (i = 0; i < (gon.notes.length); ++i) {
				setMarker(gon.notes[i]);
				array[i]=new L.LatLng(gon.notes[i].latitude,gon.notes[i].longitude)
		}
			bounds = new L.LatLngBounds(array);
			map.fitBounds(bounds)
	
	}
	
	function setMarker(note) {
			var marker = new L.Marker(new L.LatLng(note.latitude, note.longitude))
			map.addLayer(marker);
			var content = $("#note_"+note.id).html();
			marker.bindPopup(content).openPopup();
	};
	
});


