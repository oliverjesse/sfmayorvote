module ChoicesHelper
  
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
  
end