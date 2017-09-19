class Doctors

  attr_reader(:id, :name,  :speciality)

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @speciality = attributes.fetch(:speciality)
  end

  def self.all
    returned_doctors = DB.exec("SELECT * FROM doctor;")
    doctors = []
    returned_doctors.each() do |doctor|
      name = doctor.fetch("name")
      id = doctor.fetch("id").to_i()
      speciality = doctor.fetch("speciality")
      doctors.push(Doctors.new({:id => id, :name => name, :speciality => speciality}))
    end
    doctors
  end

  def save
    result = DB.exec("INSERT INTO doctor (name, speciality) VALUES ('#{@name}', '#{@speciality}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_doctor)
    self.name().==(another_doctor.name()).&(self.id().==(another_doctor.id()))
  end
end
