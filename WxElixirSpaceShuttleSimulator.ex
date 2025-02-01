# Elixsec Space Shuttle Simulator
#
# (c) Elixsec Oy 2025
#
# Feel free to use, no guarantees what so ever
#
# The purpose of the code was to test how to read keyboard natively on Elixir using wxWidget.
# Turns out this is relatively simple once correct keywords are found. I think callback-functions
# are not possible for keyboard-events, but I may have it wrong. I am not sure if the slowness is due to
# the using of messages of that the way drawing is used is very slow.
#
# spaceship_small.bmp is created by Copilot, edited and shrinked.


defmodule Esss do


  def start do

    # New wx-environment
    :wx.new()

    # Open window and bind :close_window event to it. Sends message to this process when window closed.
    frame = :wxFrame.new(:wx.null(), -1, 'Elixsec Space Shuttle Simulator', size: {800,600})
    :wxFrame.connect(frame, :close_window)

    # New panel to the frame, connect key-pressing event to it, make frame visible. Key pressing event sent as message.
    panel = :wxPanel.new(frame)
    :wxPanel.connect(panel,:key_down)
    :wxFrame.show(frame)

    # Initialize images
    spaceship_image=:wxImage.new()
    stars_image=:wxImage.new()

    # Load images from files
    :wxImage.loadFile(spaceship_image,'./spaceship_small.bmp')
    :wxImage.loadFile(stars_image,'./stars.bmp')

    # Convert Image object into Bitmap object
    spaceship_bitmap=:wxBitmap.new(spaceship_image)
    stars_bitmap=:wxBitmap.new(stars_image)

    # Set initial co-ordinates
    x=300
    y=200

    # Call funtion to draw the spaceship
    draw_spaceship(panel, spaceship_bitmap, stars_bitmap, x, y)

    # Into the game-loop.
    loop(panel, spaceship_bitmap, stars_bitmap, x, y)
  end


  def draw_spaceship(panel, spaceship_bitmap, stars_bitmap, x, y) do
    # The function to draw the space and the spaceship. Funtioning, not ideal or optimized.

    # https://www.erlang.org/doc/apps/wx/wxwindowdc
    windowDC=:wxWindowDC.new(panel)

    # Background
    :wxWindowDC.drawBitmap(windowDC,stars_bitmap,{0,0})

    # Spaceship
    :wxWindowDC.drawBitmap(windowDC,spaceship_bitmap,{x,y})

    :wxWindowDC.destroy(windowDC)
    :ok
  end



  def loop(panel, spaceship_bitmap, stars_bitmap, x, y) do
    # Example message when "q" is pressed:
    # {:wx, -31993, {:wx_ref, 36, :wxPanel, []}, [], {:wxKey, :key_down, 196, 106, 81, false, false, false, false, 81, 81, 1048577}}
    # a left, d right, w up, x down
    {x2,y2} = receive do
      {_,_,_,_,{_,_,_,_,65,_,_,_,_,_,_,_}} ->
        {-1,0}
      {_,_,_,_,{_,_,_,_,68,_,_,_,_,_,_,_}} ->
        {1,0}
      {_,_,_,_,{_,_,_,_,87,_,_,_,_,_,_,_}} ->
        {0,-1}
      {_,_,_,_,{_,_,_,_,88,_,_,_,_,_,_,_}} ->
        {0,1}
      # Exit from the program
      {_,_,_,_,{_,:close_window}} ->
        Process.exit(self(),:normal)
    end

    # Draw spaceship
    draw_spaceship(panel, spaceship_bitmap, stars_bitmap, x+x2, y+y2)

    # Loop again
    loop(panel, spaceship_bitmap, stars_bitmap, x+x2, y+y2)

    end

  end

Esss.start()
