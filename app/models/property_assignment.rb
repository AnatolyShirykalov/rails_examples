class PropertyAssignment < ApplicationRecord
  belongs_to :valueable, polymorphic: true
  belongs_to :value
  rails_admin do
    hide
  end
end
