# Elixsec Oy 2024
# Public domain
# No guarantees, no warranties, use at your own risk
#
# Usage "elixir WxNotificationMessage.ex"
# Remember to turn on notifications for this to work (Windows 10)


defmodule WxNotificationMessage do
  def notification_message do

    # Luodaan ympäristö / Create environment
    wx=:wx.new

    # Alustetaan viesti / Create new message
    message=:wxNotificationMessage.new()

    # Otsikko / Title for the message
    :wxNotificationMessage.setTitle(message,'Important message!')

    # Itse viesti / Message itself
    :wxNotificationMessage.setMessage(message,'Eat vegetables!')

    # Näytä / Show it
    # Pitäisi löytyä TaskBarin viesteistä / Should appear in TaskBar notifications
    :wxNotificationMessage.show(message)

    # Odota 5 sekuntia/Wait 5 seconds
    :timer.sleep(5000)

    # Poista muistista / Delete from memory
    :wxNotificationMessage.destoy(message)


  end
end

# Käynnistys / Start
WxNotificationMessage.notification_message
