class AdviceArea < ApplicationRecord
  has_many :support_agency_advice_areas
  has_many :support_agencies, through: :support_agency_advice_areas
end
