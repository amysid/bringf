class Content < ApplicationRecord




 def published 
    self[:published] ? 'Yes' : 'No'
  end





end
