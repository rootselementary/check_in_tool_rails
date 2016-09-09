//= require cable
//= require_self
//= require_tree .
 
App.messages = App.cable.subscriptions.create('MonitorChannel', {  
  received: function(scan) {
    return $(`.students-${scan.location_id}`).append(this.renderMessage(data));
  },

  renderMessage: function(data) {
    console.log(data)
    return "<p>" + data.data + "</p>";
  }
});