uniiv
=====
Your personal buddy to graduate in style.


#Installation
Clone the repo and install dependencies
```bash
git clone https://github.com/timcolonel/uniiv.git
bundle install
```

Install external dependencies
* Mysql server
* Graphviz

Setup the database login information for the machine

```bash
rails g uniiv:install
```

```bash
rake db:create
rake db:migrate
rake db:sync_local
```

[Javascript tools](https://github.com/timcolonel/uniiv/wiki/Javascript)


#Production
Extra step to do in production

Precompile assets
```bash
rake assets:precompile RAILS_ENV=production
```

Install solr server(The solr developement server is included in the gem already)
