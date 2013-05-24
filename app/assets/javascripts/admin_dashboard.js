$(document).ready(function() {

  //show and hide container
  $(document).on("change", '.toggle', function() {
    var ttarget = $(this).attr('href');
    $(ttarget).toggle('slow');
    return(false);
  });

  //sidebar link active after visit on.
  var loc_href = window.location.pathname;
  $('#sidebar_nav li a').each(function () {
    if (loc_href == $(this).attr('href')) {
      $(this).parent('li').addClass('active');
    }
  });


});
