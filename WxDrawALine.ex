# Elixsec Oy 2024
# Public domain
# No guarantees, no warranties, use at your own risk
#
# Usage "elixir WxDrawALine.ex"
# More drawing methods at https://www.erlang.org/doc/man/wxdc

# Elixsec Oy 2024
# Public domain
# No guarantees, no warranties, use at your own risk
#
# Usage "elixir WxDrawALine.ex"
# More drawing methods at https://www.erlang.org/doc/man/wxdc


defmodule WxDrawALine do
  def draw_a_line do

    # Luodaan ympäristö/Create environment
    wx=:wx.new

    # Määritellään ja avataan ikkuna / Define and show window
    frame=:wxFrame.new(wx,1,'Here I draw the line.')
    :wxFrame.connect(frame,:close_window)
    :wxFrame.show(frame)

    # Avataan konteksti johon piirretään / Open device context to draw to
    windowDC=:wxWindowDC.new(frame)

    # Kynän väri ja leveys / Pen color and width
    pen=:wxPen.new({0,0,0,0},[{:width, 3}])
    :wxWindowDC.setPen(windowDC,pen)

    # Piirrä viiva / Draw the line
    :wxWindowDC.drawLine(windowDC,{50,50},{150,150})

    # Tuhotaan olio. Välttämätöntä, jotta jotain saadaan näkyviin. / Destroy the object. Necessary to make drawing visible.
    :wxWindowDC.destroy(windowDC)

    loop()

  end

  def loop() do
    receive do
      {_,_,_,_,{_,:close_window}} ->
        Process.exit(self(),:normal)
      end
  end
end

# Käynnistys / Start
WxDrawALine.draw_a_line

