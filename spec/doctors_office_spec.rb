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
end
