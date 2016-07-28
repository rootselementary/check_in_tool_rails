$(document).ready(function(){
  var fixHelper = function(e, ui) {
    ui.children().each(function() {
      $(this).width($(this).width());
    });
    return ui;
  };

  $(".sortable").sortable({
    helper: fixHelper,
    placeholder: "sortable-placeholder"
  });
})
