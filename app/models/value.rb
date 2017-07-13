class Value < ApplicationRecord
  extend FriendlyId
  include Pvalue

  has_attached_file :icon
  validates_attachment_content_type :icon, content_type: /\Aimage\/.*\Z/

  friendly_id :name, use: :slugged
  has_many :property_assignments, dependent: :destroy
  has_many :cars,    through: :property_assignments, 
                     source: :valueable,
                     source_type: 'Car'
  has_many :recipes, through: :property_assignments, 
                     source: :valueable,
                     source_type: 'Recipe'
  belongs_to :property

  rails_admin do
    exclude_fields :property_assignments
    list do
      exclude_fields :cars, :recipes
    end
  end
end
