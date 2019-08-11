document.addEventListener('DOMContentLoaded', function() {
  var success = document.querySelectorAll('#flash-success');
  success.forEach(function(element) {
    let text = element.innerText
    if(text){
      console.log(text);
      M.toast({html: text, classes: 'rounded #42a5f5 blue lighten-1'});
    }
  });

  var danger = document.querySelectorAll('#flash-danger');
  danger.forEach(function(element) {
    let text = element.innerText
    if(text){
      console.log(text);
      M.toast({html: text, classes: 'rounded f44336 red'});
    }
  });
});
