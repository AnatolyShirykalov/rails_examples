module Pvalue
  extend ActiveSupport::Concern
  included do
    rails_admin do
      exclude_fields :created_at, :updated_at
      navigation_label "Спецификация"
    end
  end
end
