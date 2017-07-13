module Valuable
  extend ActiveSupport::Concern
  included do
    has_many :property_assignments, as: :valueable, dependent: :destroy
    has_many :values, through: :property_assignments

    rails_admin do
      exclude_fields :property_assignments
      navigation_label "Ассортимент"
    end
  end
end
