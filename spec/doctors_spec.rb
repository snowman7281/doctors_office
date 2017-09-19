require "rspec"
require "pg"
require "doctors"
require "patients"

DB = PG.connect({:dbname => 'doctors_office'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctor *;")
  end
end

describe(Doctors) do
  describe(".all") do
    it("starts off with no doctors in list") do
      expect(Doctors.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("tells you its name") do
      doctor = Doctors.new({:id => nil, :name => "Dr.Snow Vilay", :speciality => "oncology"})
      expect(doctor.name()).to(eq("Dr.Snow Vilay"))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      doctor = Doctors.new({:id => nil, :name => "Dr.Snow Vilay", :speciality => "oncology"})
      doctor.save()
      expect(doctor.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("lets you save lists to the database") do
      doctor = Doctors.new({:id => nil, :name => "Dr.Snow Vilay", :speciality => "oncology"})
      doctor.save()
      expect(Doctors.all()).to(eq([doctor]))
    end
  end


  describe("#==") do
    it("is the same doctor if it has the same name") do
      doctor1 = Doctors.new({:id => nil, :name => "Dr.Snow Vilay", :speciality => "oncology"})
      doctor2 = Doctors.new({:id => nil, :name => "Dr.Snow Vilay", :speciality => "oncology"})
      expect(doctor1).to(eq(doctor2))
    end
  end

  describe("#patients") do
    it("returns an array of patients for that list") do
      test_doctor = Doctors.new({:id => nil, :name => "Dr. Snow", :speciality => "cancer"})
      test_doctor.save()
      test_patient = Patients.new({:dr_id => test_doctor.id, :name => "Popular Paul"})
      test_patient.save()
      test_patient2 = Patients.new({:dr_id => test_doctor.id, :name => "Jimbolina"})
      test_patient2.save()
      expect(test_doctor.patients()).to(eq([test_patient, test_patient2]))
    end
  end
end
