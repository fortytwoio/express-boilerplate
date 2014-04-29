express-boilerplate
===================

`express-boilerplate` is a repository which aim is it to get you started with your new expressjs app very quickly. It uses express 4.x and its new router functionality with support for multiple mounted apps.
There is a `systemd` service file, nginx sample configurations and a `htpasswd` file (Username: admin, Password: admin).

This project makes use of `npm` run scripts. The idea is that you keep your `package.json` clean and correctly configured, so other developers or your DevOps just have to look at the configured scripts in your `package.json` - if at all. Think of it as the API of your app to others in your team.
The same goes with the Makefile. A Makefile with `install`, `update`, `test` and `deploy_producation` targets is included. Use this Makefile to communicate different deployment or staging steps to others. If you want to use `Grunt` or `Gulp` just write your Grunt or Gulp tasks as you normally would do, but add a target to your make file and document it there. This way it is very easy to use your app correctly.


## Setup

A `Makefile`, with `install` target is included:

```shell
make install
```

Create the `config/config.json' file. A template file is included. 
```shell
cp config/config.json.tpl config/config.json
vim config/config.json
```


## Development

During development start the app with the configured `dev` run script. This will start your app with `nodemon` listening for file changes. If a file changes, it will then automatically restart your app:
```shell
DEBUG="*" npm run dev
```

## Production

In Production you should create a init script. If you use a linux distribution with systemd you can use the `.service` file in `var/systemd-services` as a starting point. To start it manually in 'production' mode:

```shell
NODE_ENV="production" DEBUG="express-boilerplate*" npm run start
```

Thats it. :)

***If there is interest, i will add more documentation***
