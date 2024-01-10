

defmodule WxMessageDialog do
  def open_dialog_box do

    # Luodaan ympäristö/Create environment
    wx=:wx.new

    # Luodaan viestiboksi / Create MessageDialog
    # Annetaan ympäristö ja viesti / Give it environment and the message
    md = :wxMessageDialog.new(wx, "Just say yes to bucks!")

    # Näytetään boksi / Show the dialog
    # Huomaa että prosessi odottaa kunnes viesti kuitattu klikkaamalla / Note that the process waits until you have acknowledged by clicking
    :wxMessageDialog.showModal(md)

    # Vapautetaan tila / Free the memory
    :wxMessageDialog.destroy(md)

  end
end

WxMessageDialog.open_dialog_box
