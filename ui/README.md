# How to use the UI package

```
npm test
npm start
ngrok http 3000 -host-header="localhost:3000"
```

# Elm Webpack Starter Docs

Elm dev environment with hot-loading (i.e. state is retained as you edit your code - Hot Module Reloading, HMR)). I use this daily for my professional work. Like elm-community/elm-webpack-starter but using Webpack 4.

## Developing

Start with Elm debug tool with either
```sh
npm test
npm start # localhost:3000
# Share with friends!
ngrok http 3000 -host-header="localhost:3000"
```

## Production

Build production assets (js and css together) with:

```sh
npm run prod
```

## Testing

[Install elm-test globally](https://github.com/elm-community/elm-test#running-tests-locally)

`elm-test init` is run when you install your dependencies. After that all you need to do to run the tests is

```
yarn test
```

If you add dependencies to your main app, then run `elm-test --add-dependencies`

## Elm-analyse

Add pre-commit hook (@rj halp)

```sh
$ npm run analyse
```

 ## Credits

 Originally forked from https://github.com/simonh1000/elm-webpack-starter
