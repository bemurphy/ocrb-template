$(function(){
  prettyPrint();
  $("div.alert-message a.close").click(function(e){
    e.preventDefault();
    $(this).closest("div.alert-message").fadeOut(function(){
      $(this).remove();
    });
  });
});
