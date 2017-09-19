require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('viewing all of the doctors', {:type => :feature}) do
  it('allows a user to see all of the doctors that have been created') do
    doctor = Doctors.new({:id => nil, :name => 'Dr. Snow', :speciality => 'oncology'})
    doctor.save()
    visit('/')
    click_link('View All Doctors')
    expect(page).to have_content(doctor.name)
  end

  describe('seeing details for a single doctor', {:type => :feature}) do
  it('allows a user to click a doctor to see the patient and details for it') do
    test_doctor = Doctors.new({:id => nil, :name => 'Dr. Snow', :speciality => "cancer"})
    test_doctor.save()
    test_patient = Patients.new({:dr_id => test_patient.dr_id, :name => "Batman"})
    test_patient.save()
    visit('/doctors')
    click_link(test_doctor.name())
    expect(page).to have_content(test_patient.name())
  end
end
end
