$(document).ready(function(){
  sortable();
})

const fixHelper = (e, ui) => {
  ui.children().each(function() {
    $(this).width($(this).width());
  });
  return ui;
};

const sortable = function() {
  $(".sortable").sortable({
    helper: fixHelper,
    placeholder: "sortable-placeholder"
  });
};
