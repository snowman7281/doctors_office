require("rspec")
require("pg")
require("patients")

DB = PG.connect({:dbname => 'doctors_office'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM patient *;")
  end
end

describe(Patients) do
  describe(".all") do
    it("is empty at first") do
      expect(Patients.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a task to the array of saved tasks") do
      test_patient = Patients.new({:dr_id => 1, :name => "Bably Kumari"})
      test_patient.save()
      expect(Patients.all()).to(eq([test_patient]))
    end
  end

  describe("#name") do
   it("lets you read the names out") do
     test_patient = Patients.new({:dr_id => 1, :name => "Bably Kumari"})
     expect(test_patient.name()).to(eq("Bably Kumari"))
   end
 end

 describe("#dr_id") do
    it("lets you read the doctor ID out") do
      test_patient = Patients.new({:dr_id => 1, :name => "Bably Kumari"})
      expect(test_patient.dr_id()).to(eq(1))
    end
  end

  describe("#==") do
    it("is the same task if it has the same description and list ID") do
      patient1 = Patients.new({:dr_id => 1, :name => "Bably Kumari"})
      patient2 = Patients.new({:dr_id => 1, :name => "Bably Kumari"})
      expect(patient1).to(eq(patient2))
    end
  end
end
