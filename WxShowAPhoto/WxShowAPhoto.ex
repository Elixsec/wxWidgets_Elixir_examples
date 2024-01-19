# Elixsec Oy 2024
# Public domain
# No guarantees, no warranties, use at your own risk
#

defmodule WxShowAPhoto do
  def show_photo do

    # Luodaan ympäristö/Create environment
    wx=:wx.new

    # Määritellään ja avataan ikkuna / Define and show window
    frame=:wxFrame.new(wx,1,'Leena the Chow-Chow',[{:size,{180, 150}}])
    :wxFrame.show(frame)

    # Alustetaan uusi Image / New Image
    new_image=:wxImage.new()

    # Lataa kuva tiedostosta / Load image from a file
    :wxImage.loadFile(new_image,'./leenathechowchow.bmp')

    # Muunna bitmapiksi / Convert Image object into Bitmap object
    new_bitmap=:wxBitmap.new(new_image)

    # Näytä kuva / Show the picture
    :wxStaticBitmap.new(frame,15,new_bitmap)

    # Odota 10 sekuntia / Wait 10 seconds
    :timer.sleep(10000)

  end
end

# Käynnistys / Start
WxShowAPhoto.show_photo
