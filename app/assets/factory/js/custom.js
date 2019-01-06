(function($) {
    "use strict";
// ______________ PAGE LOADING
	// $(window).on("turbolinks:load", function(e) {
	$(window).on("load", function(e) {
		$("#global-loader").fadeOut("slow");
		
		// ______________ countUp
		// $('.counter').countUp();
		
			
// // ______________ Vector Map
// 		jQuery( '#vmap' ).vectorMap( {
// 			map: 'world_en',
// 			backgroundColor: null,
// 			color: '#ffffff',
// 			hoverOpacity: 0.7,
// 			selectedColor: '#1de9b6',
// 			enableZoom: true,
// 			showTooltip: true,
// 			values: sample_data,
// 			scaleColors: [ '#1de9b6', '#03a9f5' ],
// 			normalizeFunction: 'polynomial'
// 		} );

		// $('.dropdown').dropdown()
		// $('.dropdown-toggle').dropdown()
	})





	
	
	// ______________ BACK TO TOP BUTTON

	$(window).on("scroll", function(e) {
    	if ($(this).scrollTop() > 300) {
            $('#back-to-top').fadeIn('slow');
        } else {
            $('#back-to-top').fadeOut('slow');
        }
    });

    $("#back-to-top").on("click", function(e){
        $("html, body").animate({
            scrollTop: 0
        }, 600);
        return false;
    });
	// var ratingOptions = {
	// 	selectors: {
	// 		starsSelector: '.rating-stars',
	// 		starSelector: '.rating-star',
	// 		starActiveClass: 'is--active',
	// 		starHoverClass: 'is--hover',
	// 		starNoHoverClass: 'is--no-hover',
	// 		targetFormElementSelector: '.rating-value'
	// 	}
	// };
	// $(".vscroll").mCustomScrollbar();
	// $(".app-sidebar").mCustomScrollbar({
	// 	theme:"minimal",
	// 	autoHideScrollbar: true
	// });
	// $(".rating-stars").ratingStars(ratingOptions);
})(jQuery);

$(function(e) {
		  /** Constant div card */
	  const DIV_CARD = 'div.card';
	  /** Initialize tooltips */
	  $('[data-toggle="tooltip"]').tooltip();

	  /** Initialize popovers */
	  $('[data-toggle="popover"]').popover({
		html: true
	  });
			 /** Function for remove card */
	  $('[data-toggle="card-remove"]').on('click', function(e) {
		let $card = $(this).closest(DIV_CARD);

		$card.remove();

		e.preventDefault();
		return false;
	  });

	  /** Function for collapse card */
	  $('[data-toggle="card-collapse"]').on('click', function(e) {
		let $card = $(this).closest(DIV_CARD);

		$card.toggleClass('card-collapsed');

		e.preventDefault();
		return false;
	  });
	  $('[data-toggle="card-fullscreen"]').on('click', function(e) {
		let $card = $(this).closest(DIV_CARD);

		$card.toggleClass('card-fullscreen').removeClass('card-collapsed');

		e.preventDefault();
		return false;
	  });
  });





// function getRate(){
//   $.ajax({url: "/rates.json", success: function(result){
//       rates = result;
//     }});
//   $.ajax({url: "/users.json", success: function(result){
//       $.each(result, function( index, user ) {
//         var o = new Option(user.name, user.id);
//         $("#collection_user_id").append(o);
//       });
//     }});
// }

function dedlete_record(id)
{
  if(confirm('Are you sure want to delete record?'))
  {
    $("#global-loader").fadeIn("slow");
    $.ajax({url: "/collections/"+id+".json", method: 'DELETE', success: function(result){
      if(result.success){
        alert("Record Deleteed Successfully");
        var index = gon.current_collection.indexOf(parseInt(result.user_id));
        if (index > -1) {
          gon.current_collection.splice(index, 1);
        }
        $("#collectin_"+id).remove();
      }
      $("#global-loader").fadeOut("slow");
    }});
  }
}

function createCollection()
{
  data = {collection:{}}
  animal_type = $("input[name='collection[animal_type]']:checked").val()
  if(animal_type)  data.collection.animal_type = JSON.parse(animal_type );
  else {alert('Select animal Type'); return;}
  time = $("input[name='collection[time]']:checked").val()
  if(time) data.collection.time = JSON.parse(time );
  else {alert('Select Time'); return;}
  user_id = $('#collection_user_id').val()
  if(user_id) data.collection.user_id = JSON.parse(user_id);
  else {alert('Select User'); return;}
  snf = $('#collection_snf').val()
  if(snf&&snf>0) data.collection.snf = JSON.parse(snf);
  else {alert('Enter SNF Value'); return;}
  fat = $('#collection_fat').val()
  if(fat && fat>0)data.collection.fat = JSON.parse(fat);
  else {alert('Enter Fat Value'); return;}
  degree = $('#collection_degree').val()
  if(degree && degree>0) data.collection.degree = JSON.parse(degree);
  else {alert('Enter Degree Value'); return;}
  rate = $('#collection_rate').val()
  if(rate&&rate>0)data.collection.rate = JSON.parse(rate);
  else {alert('Enter Rate Value'); return;}
  litre = $('#collection_litre').val()
  if(litre &&litre>0) data.collection.litre = JSON.parse(litre);
  else {alert('Enter Litre Value'); return;}
  collection_date = $('#collection_collection_date').val()
  if(collection_date)data.collection.collection_date = collection_date;
  else {alert('Enter Date Value'); return;}

  if(gon.current_collection.includes(parseInt(user_id))){
    if (confirm("The collection for this member is already present.\n Do you want to cancel it?")){
      alert("Current collection has been canceled");
      return false ;
    }
  }

$("#global-loader").fadeIn("slow");
  $.post( "/collections.json", data, function( result ) {
    if(result.success==true){
      alert('Record Created Successfully');
      gon.current_collection.push(parseInt(user_id));
      animal_type = result.record.animal_type ? 'Cow' : 'Befflow';
      html = '<tr id = collectin_'+result.record.id+'> <td>' + result.user.name+ '</td> <td>' + result.record.fat+ '</td><td>'+ result.record.snf +'</td><td>'+ result.record.degree +'</td> <td>'+ result.record.rate +'</td> <td>'+ result.record.litre +'</td> <td>'+ animal_type  +'</td> <td><button name="button" type="submit" class="btn btn-primary ml-auto" onclick="dedlete_record('+ result.record.id +')">Destroy</button></td>'
      if($("#collections > tbody > tr:first").html())$("table > tbody > tr:first").before(html);
      else $('#collections').append(html);
      $("#user_"+result.user.id).remove();
    }
    else
      alert(result.error);
    $("#global-loader").fadeOut("slow");
  })
}

function setRate() {
  $('#collection_rate').val("")
  var fat = JSON.parse($('#collection_fat').val());
  var degree = JSON.parse($('#collection_degree').val());
  var snf = JSON.parse($('#collection_snf').val());
  var animal_type = JSON.parse( $("input[name='collection[animal_type]']:checked").val());
  if (fat>=0 && degree>=0 && snf >= 0)
  var rate = gon.rates.filter(
      function(rate){ return rate.fat == fat && rate.snf == snf  && rate.degree == degree && rate.animal_type == animal_type }
  );
  if(rate[0].rate>0){
    $('#collection_rate').val(rate[0].rate)
    if ((Number($('#collection_litre').val()))>0) $('#total').val((Number($('#collection_rate').val()))*(Number($('#collection_litre').val()))) ;
  }
}

$('#collection_collection_date, #collection_time_true, #collection_time_false').change(function() {
   window.location.href = '/collections' + "?collection_date=" + $('#collection_collection_date').val() + '&time=' + $("input[name='collection[time]']:checked").val();
});

$('#collection_fat').change(function() {
  setRate() ;
});

$('#collection_degree').change(function() {
  setRate() ;
});

$('#collection_snf').change(function() {
  setRate() ;
});

$("#collection_user_id").change(function() {
	$('#user').val(this.value);
  set_animal_type();
});

$("#collection_litre").change(function() {
  setRate() ;
});

$("#user").change(function() {
	$('#collection_user_id').val(this.value);
  set_animal_type();
	if(($('#collection_user_id option:selected').text()).length<=0) alert("User Id is not correct")
});
function set_animal_type(){

  var animal_type_value = $("#collection_user_id").find(':selected').attr('animal_type');
  $('#collection_animal_type_' + animal_type_value).prop( "checked", true );
}