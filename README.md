hex
===

Aim of this project is creating place to play [Hex board game](http://en.wikipedia.org/wiki/Hex_(board_game)) online.

# MVP

- [ x ] Initial project setup
- [ x ] Create account
- [ x ] Login
- [ ] Create game challenge
- [ ] Accept challenge
- [ ] Play move
- [ ] Decide winner

# Requirements

- npm
- bundler
- create hex-api postgresql users

# Installation

```
bundle install

rake db:migrate

npm install

node_modules/bower/bin/bower install
```

# Building & Running

To build development version (without JS minimization):

```
grunt build-dev
```

To build production version (with JS minimization):

```
grunt build
```

Grunt watch task will watch all source files changes and run build-dev:

```
grunt watch
```

Built source can be found in /public folder.

```
rails s
```

open [http://localhost:3000/](http://localhost:3000/)
