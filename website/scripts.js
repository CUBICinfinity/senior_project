$('html').click(function() {
    $('#subscribe-pop').hide();
 })

 $('#footleft').click(function(e){
     e.stopPropagation();
 });

$('#link').click(function(e) {
 $('#subscribe-pop').toggle();
 });