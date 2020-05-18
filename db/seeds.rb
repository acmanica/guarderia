# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Baby.destroy_all

Baby.create!([{"status":"SUCCESS","message":"Loaded Babies","data":[{"id":1,"name":"Merritt","age":72,"mother_name":"Winifred Pollard","father_name":"Ferdinand Gibbs","address":"4480 Egestas. Av.","phone":"1-446-909-2123"},{"id":2,"name":"Cherokee","age":60,"mother_name":"Dahlia Castro","father_name":"Zeus Huff","address":"311-7263 Cras St.","phone":"1-704-365-7793"},{"id":3,"name":"Justin","age":60,"mother_name":"Miriam Vincent","father_name":"Edan Jacobs","address":"5466 Luctus Street","phone":"1-462-622-9957"},{"id":4,"name":"Felicia","age":48,"mother_name":"Anjolie Herring","father_name":"Ali Walker","address":"436-5429 Fermentum Street","phone":"1-348-621-8566"},{"id":5,"name":"Kylynn","age":48,"mother_name":"Heidi Frank","father_name":"Lee Pacheco","address":"P.O. Box 675, 1364 Quam. St.","phone":"1-265-589-1544"}]}