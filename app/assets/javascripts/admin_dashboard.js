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

  // Like and unlike post
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

  //use for show sppiner when create comments
  $(document).on("ajax:beforeSend", 'form', function(){
    $("#loader").show();
  });

  //use for hide sppiner when ajax success
  $(document).on('ajax:success', 'form', function(){
    $("#loader").hide();
  });

});
