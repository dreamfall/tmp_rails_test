class SupportAgency < Agency
  has_many :support_agency_advice_areas, dependent: :destroy
  has_many :advice_areas, through: :support_agency_advice_areas

  accepts_nested_attributes_for :support_agency_advice_areas, allow_destroy: true

  attr_accessor :fail_validation

  validate :at_least_one_advice_area
  validate :fail_validation_method

  def fail_validation_method
    errors.add(:base, 'This is a random validation error') if fail_validation.present?
  end

  private

  def at_least_one_advice_area
    if support_agency_advice_areas.reject(&:marked_for_destruction?).empty?
      errors.add(:support_agency_advice_areas, 'must select at least one advice area')
    end
  end
end
