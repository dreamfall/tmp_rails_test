require 'rails_helper'

RSpec.describe SupportAgency, type: :model do
  describe 'changing advice areas with validation failure' do
    let!(:advice_area1) { AdviceArea.create!(name: 'Health') }
    let!(:advice_area2) { AdviceArea.create!(name: 'Education') }
    let!(:support_agency) { SupportAgency.create!(name: 'Support Agency 1', advice_areas: [advice_area1]) }

    it 'saves changes if validation succeeds' do
      params = {
        name: 'Support Agency 1',
        support_agency_advice_areas_attributes: [
          { advice_area_id: advice_area2.id },
          { id: support_agency.support_agency_advice_areas.first.id, advice_area_id: advice_area1.id, _destroy: '1' }
        ]
      }

      expect(support_agency.advice_areas).to contain_exactly(advice_area1)

      support_agency.assign_attributes(params)
      support_agency.fail_validation = false

      expect(support_agency.save).to eq(true)
      support_agency.reload
      expect(support_agency.advice_areas).to contain_exactly(advice_area2)
    end

    it 'does not save changes if validation fails' do
      params = {
        name: 'Support Agency 1',
        support_agency_advice_areas_attributes: [
          { advice_area_id: advice_area2.id }
        ]
      }

      expect(support_agency.advice_areas).to contain_exactly(advice_area1)

      support_agency.assign_attributes(params)
      support_agency.fail_validation = true

      expect(support_agency.save).to eq(false)
      support_agency.reload
      expect(support_agency.advice_areas).to contain_exactly(advice_area1)
    end
  end
end
