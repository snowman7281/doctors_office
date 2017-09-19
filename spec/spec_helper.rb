require("rspec")
require("pg")
require("doctors")
require("patients")

DB = PG.connect({:dbname => "doctors_office"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctor *;")
    DB.exec("DELETE FROM patient *;")
  end
end
