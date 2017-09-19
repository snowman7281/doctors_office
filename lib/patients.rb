class Patients
  attr_reader(:dr_id, :name)
  def initialize(attributes)
    @dr_id = attributes.fetch(:dr_id)
    @name = attributes.fetch(:name)
  end

  def self.all
   returned_patients = DB.exec("SELECT * FROM patient;")
   patients = []
   returned_patients.each() do |patient|
     name = patient.fetch("name")
     dr_id = patient.fetch("dr_id").to_i()
     patients.push(Patients.new({:dr_id => dr_id, :name => name}))
   end
   patients
 end

 def save
   result = DB.exec("INSERT INTO patient (dr_id, name) VALUES ('#{@dr_id}', '#{@name}');")
 end

 def ==(another_patient)
   self.name().==(another_patient.name()).&(self.dr_id().==(another_patient.dr_id()))
 end

end
