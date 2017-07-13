class Car < ApplicationRecord
  include Valuable
  rails_admin do
    weight -10
  end
end
