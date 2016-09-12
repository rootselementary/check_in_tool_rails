//= require cable
//= require_self
//= require_tree .
 
App.messages = App.cable.subscriptions.create('MonitorChannel', {  
  received: (monitorPayload) => {
    let divClass = `.students-${monitorPayload.scan.location_id}` 
      addStudent(monitorPayload, divClass)      
  }
});

const addStudent = (monitorPayload, divClass) => {
  let studentCollection = $(`${divClass}`)
  let student = monitorPayload.student
  let status = monitorPayload.scan.correct
  let location = monitorPayload.location
  if (status) {
    studentCollection.append(studentTemplate(student, location, "scanned-in"))
  } else {
    studentCollection.append(studentTemplate(student, location, "enroute"))
  }
}

const studentTemplate = (student, location, status) => { 
    return  `<div class='col-md-3 col-sm-6 student'> 
              <div id='studentGM-${student.id}' class=${status}>
                ${createNameH3(student.name)}
                ${studentImage(student)}
                ${markAsStatusButton(student, location)}
              </div>
           </div>`
}

const createNameH3 = (studentName) => {
  return `<h3>${studentName}</h3>`
}

const studentImage = (student) => {
   if (student.google_image) return ('<img>', {src: student.google_image});
   return ''
 }

const markAsStatusButton = (student, location) => {
  if (student.at_school) {
      return `<a class='btn btn-default' rel='nofollow' data-method='patch' 
      href='/admin/grove-monitor-all?filter=location&amp;id=${student.id}&amp;name=${location}&amp;student%5Bat_school%5D=false'>
      Mark as Absent </a>`
  } else {
      return `<a class='btn btn-default' rel='nofollow' data-method='patch' 
      href='/admin/grove-monitor-all?filter=location&amp;id=${student.id}&amp;name=${location}&amp;student%5Bat_school%5D=true'>
      Mark as Present </a>`
  }
}
