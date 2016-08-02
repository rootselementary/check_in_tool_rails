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
  $('#submit-playlist').prop('disabled', false)
  let rows = $('.sortable').children('tr');
  rows.each( function(index) {
    $(this).data('position', index);
  })
}

const activityObject = {}

const activityData = () => {
  let rows = $('.sortable').children('tr');
  rows.each(function(index){
    let id = this.id.split('-')[2]
    activityObject[id] = $(this).data("position")
  })
  return activityObject;
}

const updatePositions = () => {
  let id = window.location.href.split('/')[5];
  let data = { positions: activityData() }
  let playlist_activity_id = Object.keys(data["positions"])[0];
  let url = `/api/v1/admin/students/${id}/playlist_activities/${playlist_activity_id}`;

  $.ajax({
    type: "PATCH",
    url: url,
    dataType: 'JSON',
    data: { data: data },
    success: () => {
      $('#submit-playlist').prop('disabled', true)
    }
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
