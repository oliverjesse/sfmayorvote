module ChoicesHelper
  
  def pretty_link(link)
    return "" unless link.present?
    link_to(" [more info] ",link)
  end
  
end