# ~dotfiles

Enter on the .dotfiles directory and execute the following commands:

```
$ make deps
$ make install
```

Now set up your credentials.

```
$ git config --global user.name "Jonh Doe"
$ git config --global user.email jonh@doe.com
```

### disableweb

```javascript
// ~/.hyper_plugins/disableweb/index.js

exports.middleware = (store) => (next) => (action) => {
  if (action.type !== 'SESSION_URL_SET') {
    next(action)
  } else {
    console.log('Intercepted SESSION_URL_SET')
  }
}
```
