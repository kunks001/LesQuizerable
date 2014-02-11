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

    var Target = $('#questions .question_fields:last');
    var CloneTarget = $(Target).clone( true );

    CloneTarget.find('input, select').val('').attr('name', function(i, val) {
        return val.replace(/\d+/, function(n) {
            return ++n;
        });
    });

    $('#questions').append(CloneTarget);
    $('.add_question_fields').appendTo('#questions');
  });
});

$(document).ready(function() {
  $(".add_answer").click(function(){
    event.preventDefault(); 

    var Container = $(this).parents().eq(4)
    var AddAnswerContainer = $(this).parents().eq(3)
    var Target = $( "#questions .answer_fields:last" );
    var CloneTarget = $(Target).clone( true );

    CloneTarget.find('input, select').val('').attr('name', function(i, val) {
        return val.replace(/\d+(?=[^\d+]*$)/, function(n) {
            return ++n;
        });
    });

    Container.append(CloneTarget);
    AddAnswerContainer.appendTo(Container);
    $('.add_question_fields').appendTo('#questions');
  });
});


$(function() {
  $('.remove_question').click(function(event) {
    event.preventDefault();
    $(this).parents().eq(5).remove();
  });
});

$(function() {
  $('.remove_answer').click(function(event) {
    event.preventDefault();
    $(this).parents().eq(3).remove();
  });
});