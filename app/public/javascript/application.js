$(document).ready(function() {
  $("form#attempts_form").on('submit', function(event) {
    event.preventDefault();

    $form = $(this).closest( '#attempts_form' );
    // alert('the action is: ' + $form.attr('action'));

    $.ajax({
      url: $form.attr('name'),
      dataType: "json",
      data: $("#attempts_form").serialize(),
      type: "POST",
      success: function( score ){
      // window.location.reload();
        // alert( msg )
        document.getElementById('show-score').innerHTML = score
      },
      error: function(){
        alert("You've got to answer some questions first!")
      }
    });
  });
});

$(document).ready(function() {
  $(".add_question").click(function(event){
    event.preventDefault(); 
    var Target = $('.question_fields:last');
    var CloneTarget = $(Target).clone();

    CloneTarget.find('input, select').attr('name', function(i, val) {
        return val.replace(/\d+/, function(n) {
            return ++n;
        });
    });

    $('#questions').append(CloneTarget);
  });
});

$(document).ready(function() {
  $(".add_answer").click(function(){
    event.preventDefault(); 
    var Target = $(this).parent().parent().children(".answer_fields").last();
    var CloneTarget = $(Target).clone();

    CloneTarget.find('input, select').attr('name', function(i, val) {
        return val.replace(/\d+(?=[^\d+]*$)/, function(n) {
            return ++n;
        });
    });

    $(this).parent().parent().append(CloneTarget);
    $(this).parent().appendTo('.question_fields');
  });
});