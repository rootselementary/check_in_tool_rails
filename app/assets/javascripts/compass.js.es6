let checkId,
    timeRemaining = 0;

const timeoutDuration = 500;

function checkForNewEvent() {
  timeRemaining -= timeoutDuration;
  if (timeRemaining <= 0) {
    clearInterval(checkId);
    $('.event-details').toggleClass('hidden');
  }
}

$(function(){
    if ($(".event-details").length > 0) {
    timeRemaining = parseInt($('.event-details.ongoing').data('duration'));
    checkId = setInterval(checkForNewEvent, timeoutDuration);
  }
});

