// $(document).ready(function() {
// $(".submit_password").click(function() {
//         var id = $(this).attr('id');
//         var newdesignation =  $('#newdesignation'+ id).val();
//         var newcompany =  $('#newcompany'+ id).val();
//         var newphone = $('#newphone'+ id).val();
//         var newemail = $('#newemail'+ id).val();
//         var newremarks = $('#newremarks'+ id).val();
//         $.ajax({
//         type: "GET",
//         url: "/update/data",
//         data: { 'id' : id, 'designation' : newdesignation, 'company' : newcompany, 'phone' : newphone,  'email' : newemail,  'remarks' : newremarks },
//         success: function(){
//         window.location.reload();
//         }

//       });
//      });
// })

$(document).ready(function() {
	$(".add_question").click(function(event){
	  event.preventDefault(); 
	  var Target = $('.question:last');
	  var CloneTarget = $(Target).clone();

	  CloneTarget.find('input, select').attr('name', function(i, val) {
		    return val.replace(/\d+/, function(n) {
		        return ++n;
		    });
		});

	  $('#questions').append(CloneTarget);
	});
});