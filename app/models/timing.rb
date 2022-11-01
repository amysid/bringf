class Timing < ApplicationRecord

  belongs_to :location

  enum day: [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]
  #validates :day, inclusion: { in: [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday] }
end
