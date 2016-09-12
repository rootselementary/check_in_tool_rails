//= require cable
//= require_self
//= require_tree .
 
App.messages = App.cable.subscriptions.create('MonitorChannel', {  
  received: function(monitorPayload) {
    let scan = monitorPayload.scan
    let student = monitorPayload.student
    let divClass = `.students-${scan.location_id}` 
      studentName(student.name, divClass)
      if (student.google_image) {
        studentImage(student.google_image, divClass)
      }
  }
});

const studentName = function(studentName, divClass) {
  return $(`${divClass}`).append(`<h3>${studentName}</h3>`)
}
const studentImage = function(studentImage, divClass) {
  let img = ('<img>', {
    src: studentImage,
  });
  img.appendTo($(`${divClass}`));
}



// `<div class="col-md-3 col-sm-6 student"
//       <div class="<%= student.scanned_in? ? "scanned-in": "enroute" %>">
//         <h3><%= student.name %></h3>
//         <%= image_tag student.google_image, class: "student-image" if student.google_image %>
//         <% if student.at_school %>
//           <%= link_to "Mark as Absent", admin_update_grove_monitor_all_path(id: student.id, student: { at_school: false }, filter: params[:filter], name: params[:name]), method: :patch, class: "btn btn-default" %>
//         <% else %>
//         <%= link_to "Mark as Present", admin_update_grove_monitor_all_path(id: student.id, student: { at_school: true }, filter: params[:filter], name: params[:name]), method: :patch, class: "btn btn-default" %>
//     <% end %>
//   </div>
// </div>`

