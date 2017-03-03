Deeper Dive
===

A deeper look at you versus your opponent in League of Legends.

Development Installation
---
1. Install ruby 2.3.1 (recommend [rbenv](https://github.com/rbenv/rbenv): `rbenv install 2.3.1 && rbenv local 3.2.1`)
2. Install Postgres
3. Install bundler (`gem install bundler`)
4. `bundle install`
5. `rake db:create && rake db:migrate`

Note: if using rbenv, you may have run `rbenv rehash` after installing bundler, and rails.

Next you'll want to create a Summoner. From the `rails console`:
```ruby
Summoner.create(name: 'Tinfin', riot_id: 77121) # NOTE: you'll need to find out the summoner ID as displayed by Riot
```

To import matches, [grab an API key from Riot Games](https://developer.riotgames.com/sign-in) and run `rake riot_sync:new_matches`

Run `rails server` and check out http://localhost:3000 to see the matches.

Contributing
---
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
