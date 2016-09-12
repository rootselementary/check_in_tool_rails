//= require cable
//= require_self
//= require_tree .
 
App.messages = App.cable.subscriptions.create('MonitorChannel', {  
  received: (monitorPayload) => {
    console.log(monitorPayload)
    let scan = monitorPayload.scan
    let student = monitorPayload.student
    let divClass = `.students-${scan.location_id}` 
      addStudent(student.name, divClass, scan.correct)
      if (student.google_image) {
        studentImage(student.google_image, divClass)
      }      
  }
});

const addStudent = (studentName, divClass, status) => {
  let appendable = $(`${divClass}`).children(".student")
  if (status) {
    appendable.append(`
    <div class="scanned-in">
      <h3>${studentName}</h3>
    </div>`)
  } else {
    appendable.append(`
    <div class="enroute">
      <h3>${studentName}</h3>
    </div>`)
  }

}

const studentImage = (studentImage, divClass) => {
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

