# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

calendar = Calendar.create({code: "4/sKj-4D97VtQ7nHKIryrRa-yEPnzu.0trI63WI3O8XaDn_6y0ZQNgGcoIOegI",
                           client_id: "759068570332.apps.googleusercontent.com",
                           client_secret: "7amw71XAAyReH92K_LtOp5-a",
                           redirect_uri: "https://localhost/oauth2callback",
                           access_token: "ya29.AHES6ZQsX4fsVjNY9G3a9TOU3-h49X3r128DaWNPv_YCMuK3c8rXXQ",
                           refresh_token: "1/6pC6Dwsax6BzqZOfJ3C28e7K9wBUEv5uYmOvfRNQ560",
                           calendar_id: "almultaqa.events@gmail.com",
                           last_update: DateTime.now.advance(days: -7)})
calendar.save!

nyuad = School.create({name: "NYUAD", image: "/assets/nyuad.jpg"})
claflin = School.create({name: "Claflin", image:"/assets/claflin.jpg"})
zayed = School.create({name: "Zayed University", image:"/assets/zayed.jpg"})

nyuad.save!
claflin.save!
zayed.save!

