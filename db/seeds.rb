# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.where(username: 'admin')

if u.blank?

	User.create(username: 'admin', password: 'MyAdmin123', password_confirmation: 'MyAdmin123', email: 'admin@gmail.com')
end