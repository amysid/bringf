 /* =================Lov Patsariya============= */
$(document).ready(function(){
	
 //$('.datatable').DataTable();
  
  /* -----------Date Picker -------*/
	$('.datepicker,.departure-field').datepicker({
			autoclose: true
    });
	/* -----------Date Picker End-------*/

/* ========For Image Change========== */
 $('input[type=file]').change(function() {
   
            readURL(this);
        });
 
 
  function readURL(input) {
  
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function(e) {
                    $('.account-user-img img').attr('src', e.target.result).fadeIn('slow');
                }
                reader.readAsDataURL(input.files[0]);
            }
        }


});/* ==============Ready End============ */

/* ==============Scrollable Menu============ */
  $(window).scroll(function(){
	   var scroll = $(window).scrollTop();
	  if(scroll>1){
		  $(".global-header").addClass("scrollheader");
	  }
	  else{
		  $(".global-header").removeClass("scrollheader");
	  }
  });
/* =============Scrollable Menu End======== */

