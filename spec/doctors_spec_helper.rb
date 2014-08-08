require 'doctor'
require 'patient'
require 'specialty'
require 'insurance'
require 'pg'

DB = PG.connect(:dbname => 'doctors_office_test')

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctors *;")
    DB.exec("DELETE FROM patients *;")
    DB.exec("DELETE FROM specialties *;")
    DB.exec("DELETE FROM insurance *;")
  end
end
