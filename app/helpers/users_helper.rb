module UsersHelper
  def platform_image(user)
    if user.platform == "PC"
      "/assets/pc.png"
    elsif user.platform == "PS4 or Xbox"
      "/assets/ps4.png"
    elsif user.platform == "Switch"
      "/assets/switch.png"
    else
      "/assets/mobile.png"
    end
  end
end
