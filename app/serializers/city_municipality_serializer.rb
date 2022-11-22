class CityMunicipalitySerializer < ActiveModel::Serializer
  attributes :name, :district, :province, :id,

  def region
    object.district.name
  end

  def region
    object.province.name
  end
end