module ChoicesHelper

  def pretty_percent(c)
    number_to_percentage(c * 100, :precision => 0)
  end

  def pretty_link(link)
    return "" unless link.present?
    link_to(" [more info] ",link)
  end

  def rank(choice_counter)
    choice_counter + 1
  end

  def choice_image_url(choice)
    "/images/politician-" + choice.name.split.last.downcase + ".jpg"
  end

  def link_to_choice(text, choice)
    if choice.link.present?
      link_to(text, choice.link, :style => "color: #666;")
    else
      text
    end
  end
end
