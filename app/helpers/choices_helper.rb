module ChoicesHelper
  
  def pretty_percent(c)
    (c * 100).to_i.to_s + "%"
  end
  
  def pretty_link(link)
    return "" unless link.present?
    link_to(" [more info] ",link)
  end
  
  def rank(choice_counter)
    choice_counter + 1
  end
  
  def alpha(c)
    return "alpha" if (c % 4 == 0)
    ""
  end
  
  def choice_image_url(choice)
    "/images/politician-" + choice.name.split.last.downcase + ".jpg"
  end
end