var checkId;
$(function(){
  if ($(".compass-details").length > 0) {
    checkId = setInterval(checkForNewEvent, 500);
  }
});

function checkForNewEvent() {
  var time = new Date().getTime();
  if ($('.compass-details').data('endtime') < time ) {
    clearInterval(checkId);
    location.reload(true);
  }
}
