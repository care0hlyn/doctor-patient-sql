class Doctor
  attr_reader :id, :name, :specialty_id, :insurance_id

  def initialize(attributes)
    @id = attributes['id']
    @name = attributes['name']
    @specialty_id = attributes['specialty_id']
    @insurance_id = attributes['insurance_id']
  end

  def ==(another_doctor)
    self.name == another_doctor.name
  end

  def save
    results = DB.exec("INSERT INTO doctors (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    results = DB.exec("SELECT * FROM doctors;")
    doctors = []
    results.each do |result|
      new_doctor = Doctor.new(result)
      doctors << new_doctor
    end
  doctors
  end

  def assign_specialty(doctor_id, specialty_id)
    results = DB.exec("UPDATE doctors SET specialty_id = #{specialty_id} WHERE id = #{doctor_id} RETURNING specialty_id;")
    @specialty_id = results.first['specialty_id'].to_i
  end

  def assign_insurance(doctor_id, insurance_id)
    results = DB.exec("UPDATE doctors SET insurance_id = #{insurance_id} WHERE id =#{doctor_id} RETURNING insurance_id;")
    @insurance_id = results.first['insurance_id'].to_i
  end

  def self.list_doctors_by_specialty(name)
    specialty_results = DB.exec("SELECT * FROM specialties WHERE name = '#{name}';")
    @id = specialty_results.first['id'].to_i
    results = DB.exec("SELECT * FROM doctors WHERE specialty_id = #{@id};")
    doctors = []
    results.each do |result|
      new_doctor = Doctor.new(result)
      doctors << new_doctor
    end
  doctors
  end

  def self.search_doctor(name)
    results = DB.exec("SELECT * FROM doctors WHERE name = '#{name}';")
    doctors = []
    results.each do |result|

      doctors << result
    end
    doctors
    # binding.pry\
  end

  # def update(name)
  #   DB.exec("UPDATE doctors SET name = '#{name}';")

  # end

end
