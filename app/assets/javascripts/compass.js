var checkId;
var timeRemaining = 0;

$(function(){
  if ($(".event-details").length > 0) {
    timeRemaining = parseInt($('.event-details.ongoing').data('duration'));
    checkId = setInterval(checkForNewEvent, 500);
  }
});

function checkForNewEvent() {
  timeRemaining -= 500;
  if (timeRemaining <= 0) {
    clearInterval(checkId);
    $('.event-details').toggleClass('hidden');
  }
}
