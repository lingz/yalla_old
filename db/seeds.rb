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
                           calendar_id: "almultaqa.events@gmail.com"})
calendar.save!

nyuad = School.create({name: "NYUAD"})
claflin = School.create({name: "Claflin"})
zayed = School.create({name: "Zayed University"})

nyuad.save!
claflin.save!
zayed.save!

ling = nyuad.users.create({name: "Lingliang Zhang", password: "password",
                          display_image: "ling.jpg"})
ling.save!
ling.emails.append(Email.create({address: "lingliang.zhang@nyu.edu", user_id: ling.id}))
alice = nyuad.users.create({name: "Alice Tessen", password: "password",
                          display_image: "alice.jpg"})
alice.save!
alice.emails.append(Email.create({address: "aet289@nyu.edu", user_id: alice.id}))
jessica = claflin.users.create({name: "Jessica Mong", password: "password",
                          display_image: "jessica.jpg"})
jessica.save!
jessica.emails.append(Email.create({address: "jessymong@gmail.com", user_id: jessica.id}))
sharmina = zayed.users.create({name: "Sharmina hague Nayeema", password: "password",
                          display_image: "sharmina.jpg"})
sharmina.save!
sharmina.emails.append(Email.create({address: "animi.masud@gmail.com", user_id: sharmina.id}))
anoud = zayed.users.create({name: "Anoud Mahmoud Thoban", password: "password",
                          display_image: "anoud.jpg"})
anoud.save!
anoud.emails.append(Email.create({address: "aanoud664@gmail.com", user_id: anoud.id}))
sara = zayed.users.create({name: "Sara Al Hammad", password: "password",
                          display_image: "sara.jpg"})
sara.save!
sara.emails.append(Email.create({address: "asmile2.life@hotmail.com", user_id: sara.id}))

basketball = sara.events.create({name: "Basketball", location: "Zayed Sports Center",
                                start_time: DateTime.now.advance(hours: 2), end_time: DateTime.now.advance(hours: 4), 
                                description: "Basketball game: Zayed v. NYUAD", image: "basketball.jpg",
                                status: "active"})
bowling = ling.events.create({name: "Bowling", location: "Zayed Sports City",
                                start_time: DateTime.now.advance(hours: 6, minutes: 21), end_time: DateTime.now.advance(hours: 10, minutes: 28), 
                                description: "Basketball game: Zayed v. NYUAD", image: "basketball.jpg",
                                status: "active"})
computer = jessica.events.create({name: "Computer Science Seminar", location: "Claflin University",
                                start_time: DateTime.now.advance(hours: 3, minutes: 15), end_time: DateTime.now.advance(hours: 5, minutes: 35), 
                                description: "Basketball game: Zayed v. NYUAD", image: "basketball.jpg",
                                status: "active"})
computer.save!
comment = computer.comments.create({description: "This is awesome! I'm definiately going to go to this!"})
