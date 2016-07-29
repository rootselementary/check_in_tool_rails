$(document).ready(function(){
  sortable();
  savePositions();
})

const fixHelper = (e, ui) => {
  ui.children().each(function() {
    $(this).width($(this).width());
  });
  return ui;
};

const setPosition = () => {
  let rows = $('.sortable').children('tr');
  rows.each( function(index) {
    $(this).data('position', index);
  })
}

const activityObject = {}

const activityData = () => {
  let rows = $('.sortable').children('tr');
  rows.each(function(index){
    id = this.id.split('-')[2]
    activityObject[id] = $(this).data("position")
  })
  return activityObject;
}

const updatePositions = () => {
  let id = window.location.href.split('/')[5];
  let url = `/api/v1/admin/playlist_activities/${id}`;
  let activities = activityData();
  let data = { activities: activities, student_id: id }
  $.ajax({
    type: "PATCH",
    url: url,
    dataType: 'JSON',
    data: { data: data }
  });
}

const sortable = () => {
  $(".sortable").sortable({
    helper: fixHelper,
    placeholder: "sortable-placeholder",
    update: setPosition
  });
};

const savePositions = () => {
  $('#submit-playlist').on('click', function(e) {
    e.preventDefault();
    updatePositions();
  });
}
