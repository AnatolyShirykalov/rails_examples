class RecipesController < ApplicationController
  def index
    @filter = CommonFilter.new(Recipe, recipe_params)
    @recipes = @filter.models.page(params[:page]).per(20)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  private
  def recipe_params
    params.slice(:ingredient, :author, :country)
  end
end
