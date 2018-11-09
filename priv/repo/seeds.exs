# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TaskTrackerSpa.Repo.insert!(%TaskTrackerSpa.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias TaskTrackerSpa.Repo
alias TaskTrackerSpa.Users.User

pwhash = Argon2.hash_pwd_salt("pass1")
pwhash2 = Argon2.hash_pwd_salt("pass2")


Repo.insert!(%User{email: "alice@example.com", admin: true, password_hash: pwhash})
Repo.insert!(%User{email: "bob@example.com", admin: false, password_hash: pwhash2})

alias TaskTrackerSpa.Tasks.Task
Repo.insert!(%Task{title: "Do homework", description: "Finish tomorrow's homework", userassigned: "alice@example.com", 
                  timespent: 4.5, completed: false})
Repo.insert!(%Task{title: "Cook dinner", description: "Cook rice for dinner", userassigned: "bob@example.com", 
                  timespent: 2, completed: true})

