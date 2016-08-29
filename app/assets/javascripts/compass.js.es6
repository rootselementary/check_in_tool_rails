let endTime;

$(function(){
    if ($(".event-details").length > 0) {
      timeRemaining = parseInt($('.event-details.ongoing').data('duration'));
      endTime = Date.now() + timeRemaining;
      checkTime();
    }
});

function checkTime() {
  if (Date.now() <= endTime) {
    requestAnimationFrame(checkTime);
  } else {
    $('.event-details').toggleClass('hidden');
  }
}
