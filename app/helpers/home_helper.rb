require "httparty"
require "nokogiri"

module HomeHelper
  def fetch_menu_data(page_url)
    response = HTTParty.get(page_url)
    doc = Nokogiri::HTML(response.body)

    sections = doc.css(".row.mr-1.ml-2.mt-1.mb-1").first&.elements || []
    sections.map do |section|
      {
        title: section.at_css(".pietanze")&.text&.strip,
        items: parse_items(section)
      }
    end
  end

  def parse_items(section)
    items_container = section.at_css(".col-12.text-left")&.elements || []
    items_container.each_slice(2).map do |item_element, ingredient_element|
      next unless item_element

      {
        name: item_element.text.gsub("-", "").strip,
        glutenFree: item_element.at_css("img[src='/Menu/img/gluten.png']").present?,
        lactoseFree: item_element.at_css("img[src='/Menu/img/lactose.png']").present?,
        ingredientiAllergeni: extract_allergens(ingredient_element),
        ingredienti: extract_ingredients(ingredient_element)
      }
    end.compact
  end

  def extract_allergens(ingredient_element)
    return [] unless ingredient_element

    allergens = ingredient_element.css("strong").map { |tag| tag.text.gsub(",", "") }
    ingredient_element.css("strong").remove # Remove strong tags from original HTML
    allergens
  end

  def extract_ingredients(ingredient_element)
    return [] unless ingredient_element

    ingredients_text = ingredient_element.text.gsub(/[()\n\r]/, "").strip
    ingredients_text.split(", ").map(&:strip)
  end
end
