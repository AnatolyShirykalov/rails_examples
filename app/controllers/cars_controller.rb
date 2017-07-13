class CarsController < ApplicationController
  def index
    @filter = CommonFilter.new(Car, filter_params)
    @cars = @filter.models.page(params[:page]).per(20)
  end

  def show
    @car = Car.find(params[:id])
  end

  private
  def filter_params
    params.slice(*%i[base_color drivetrain engine_cylinders fuel_type interior_upholstery transmission])
  end
end
