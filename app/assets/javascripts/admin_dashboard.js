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

  // Follow a customer or Like any entity.
  $('.like').on('click', function() {
    var id = $(this).attr('data-id');
    var me = $(this);
    var url = '/public/blogs/'+id+'/like'

    $.get(url, { id : id}, function(data) {
      if (data != 'fail') {
        me.html(data);
      }
    });
    return false;
  });
  //end

});
