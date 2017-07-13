class Property < ApplicationRecord
  extend FriendlyId
  include Pvalue
  friendly_id :name, use: :slugged
  has_many :values, dependent: :destroy
  rails_admin do
    weight -1
    list do
      exclude_fields :values
    end
  end
end
