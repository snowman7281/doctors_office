require('sinatra')
require('sinatra/reloader')
require('./lib/doctors')
require('./lib/patients')
also_reload('lib/**/*.rb')
require("pg")


DB = PG.connect({:dbname => "doctors_office"})


get("/") do
  erb(:index)
end

get('/doctors') do
  @doctors = Doctors.all()
  erb(:doctors)
end

get("/doctors/new") do
  erb(:doctor_form)
end

post("/doctors") do
  id = params.fetch("id").to_i()
  name = params.fetch("name")
  speciality = params.fetch("speciality")
  doctor = Doctors.new({:id => nil, :name => name, :speciality => speciality})
  doctor.save()
  erb(:doctor_success)
 end

 get("/doctors/:id") do
   @doctors = Doctors.find(params.fetch("id").to_i())
   erb(:doctors)
 end
