# How to use the UI package

```
npm test
npm start
ngrok http 3000 -host-header="localhost:3000"
npm run prod
# take bundle and drop it into your static site
```

# Elm Webpack Starter Docs

Elm dev environment with hot-loading (i.e. state is retained as you edit your code - Hot Module Reloading, HMR)). I use this daily for my professional work. Like elm-community/elm-webpack-starter but using Webpack 4.

## Developing

Start with Elm debug tool with either
```sh
$ npm start
```

Open http://localhost:3000 and start modifying the code in /src.  **Note** that this starter expects you have installed [elm-format globally](https://github.com/avh4/elm-format#installation-).

An example using Routing is provided in the `navigation` branch

## Production

Build production assets (js and css together) with:

```sh
npm run prod
```

## Static assets

Just add to `src/assets/` and the production build copies them to `/dist`

## Testing

[Install elm-test globally](https://github.com/elm-community/elm-test#running-tests-locally)

`elm-test init` is run when you install your dependencies. After that all you need to do to run the tests is

```
yarn test
```

Take a look at the examples in `tests/`

If you add dependencies to your main app, then run `elm-test --add-dependencies`

<!-- I have also added [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples) and provided an example in the definition of `add1` in App.elm. -->

## Elm-analyse

Elm-analyse is a "tool that allows you to analyse your Elm code, identify deficiencies and apply best practices." Its built into this starter, just run the following to see how your code is getting on:

```sh
$ npm run analyse
```

## Circle CI

```sh
$ circleci local execute --job build
```

<hr />

## ES6

This starter includes [Babel](https://babeljs.io/) so you can directly use ES6 code.

 ## Credits

 Originally forked from https://github.com/simonh1000/elm-webpack-starter
