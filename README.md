# cap-localhost-deploy
Example Rails app to deploy code onto local server

### Install

1. Clone this repo onto the local server
2. Run `bundle install`
3. Configure the `:deploy_to` path in config/deploy.rb
4. Configure the `:linked_files` and `:linked_dirs` in config/deploy.rb
5. Write a task to restart your server
6. Deal with compiling assets, if necessary
