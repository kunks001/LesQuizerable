$(document).ready(function() {
  $("form#attempts_form").on('submit', function(event) {
    event.preventDefault();

    $form = $(this).closest( '#attempts_form' );
    // alert('the action is: ' + $form.attr('action'));
    // var Data = $("#attempts_form").serialize()
    // console.log(Data)

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

function checkedRadioButton(obj){
  var id = obj.name.substring(obj.name.lastIndexOf());
  var el = obj.form.elements;
  for (var i = 0; i < el.length; i++) {
      if (el[i].name.substring(el[i].name.lastIndexOf()) == id) {
          el[i].checked = false;
      }
  }
  obj.checked = true;
}

$(document).ready(function() {
  $(".add_question").click(function(event){
    event.preventDefault(); 

    var Target = $('#questions .question_fields:last');
    var CloneTarget = $(Target).clone( true );

    CloneTarget.find('input, select').attr('name', function(i, val) {
        return val.replace(/\d+/, function(n) {
            return ++n;
        });
    });

    CloneTarget.find('input:text').val('');
    CloneTarget.find('input:checkbox').attr('checked', false);

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

    CloneTarget.find('input, select').attr('name', function(i, val) {
        return val.replace(/\d+(?=[^\d+]*$)/, function(n) {
            return ++n;
        });
    });

    CloneTarget.find('input:text').val('');
    CloneTarget.find('input:checkbox').attr('checked', false);

    Container.append(CloneTarget);
    AddAnswerContainer.appendTo(Container);
    $('.add_question_fields').appendTo('#questions');
  });
});


$(function() {
  $('.remove_question').click(function(event) {
    event.preventDefault();
    $(this).parents().eq(4).remove();
  });
});

$(function() {
  $('.remove_answer').click(function(event) {
    event.preventDefault();
    $(this).parents().eq(3).remove();
  });
});