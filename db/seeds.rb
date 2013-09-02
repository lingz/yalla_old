# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

calendar = Calendar.create({code: "4/4Mt_ULTtrxwsNq_osEgXcepzwe9D.4mHA91ZWNwQYaDn_6y0ZQNiS4vTMewI",
                           client_id: "759068570332.apps.googleusercontent.com",
                           client_secret: "7amw71XAAyReH92K_LtOp5-a",
                           redirect_uri: "https://localhost/oauth2callback",
                           access_token: "ya29.AHES6ZQQk4viAeJNsnx9HKbigvCttSGrgDbxOSfyI4XDFEpkRLcddQkkk",
                           refresh_token: "1/m6hI1KK-dLsFyD6jnLaTaNao9QMk-86pLE_0-6h_LdU",
                           calendar_id: "nyuad.yalla@gmail.com",
                           last_update: DateTime.now.advance(days: -7),
                           calls: 0})
calendar.save!

nyuad = School.create({name: "NYUAD", image: "/assets/nyuad.jpg"})

nyuad.save!
