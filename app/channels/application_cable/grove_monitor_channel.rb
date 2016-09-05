class GroveMonitorChannel < ActionCable::Channel
  def subscribed 
    stream_from 'users'
  end 
end