class Api::CityMunicipalitiesController < ApplicationController

  def index
    province = Address::Province.find_by_id(params[:province_id])
    district = Address::District.find_by_id(params[:district_id])
    if province
      city_municipalities = province.city_municipalities
      render json: city_municipalities, each_serializer: CityMunicipalityProvinceSerializer
    else
      city_municipalities = district.city_municipalities
      render json: city_municipalities, each_serializer: CityMunicipalityDistrictSerializer
    end
  end
end
