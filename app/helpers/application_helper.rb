module ApplicationHelper
  def find_country_name_by_country_id(country_id)
    country_name = Country.find_by(id: country_id).country_name
  end



end
