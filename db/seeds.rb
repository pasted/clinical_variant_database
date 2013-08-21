# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

chromosomes_a = Chromosome.create([{ name: '1' }, { name: '2' }, { name: '3' }, { name: '4' }, { name: '5' }, { name: '6' }])
chromosomes_b = Chromosome.create([{ name: '7' }, { name: '8' }, { name: '9' }, { name: '10' }, { name: '11' }, { name: '12' }])
chromosomes_c = Chromosome.create([{ name: '13' }, { name: '14' }, { name: '15' }, { name: '16' }, { name: '17' }, { name: '18' }])
chromosomes_d = Chromosome.create([{ name: '19' }, { name: '20' }, { name: '21' }, { name: '22' }, { name: 'X' }, { name: 'Y' }, { name: 'MT' }])
