# Requirements

- npm

# Installation

```
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

Built source can be found in dist folder.

## http-server

```
npm install http-server

cd dist && http-server
```

open [http://localhost:8080](http://localhost:8080).

## python

```
python -m SimpleHTTPServer
```

open [http://localhost:8000](http://localhost:8000).
