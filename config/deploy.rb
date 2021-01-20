# config valid for current version and patch releases of Capistrano
lock "~> 3.15.0"

set :application, "catalyst"
set :repo_url, "git@github.com:jhu-library-applications/catalyst-blacklight.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/Users/ewlarson/Rails/clients/jhu/cap-fake-server"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

namespace :deploy do
  before :starting, :get_deploy_tag
  before :starting, :git_push
  # after :finishing, :restart @TODO
  # after :updated, :compile_assets @TODO

  desc 'Restart passenger'
  task :restart do
    on roles(:app) do
      # These are for the systemd deployments
      # capistrano-passenger?
    end
  end

  desc 'push tags and changes'
  task :git_push do
    puts `git push origin master`
    puts `git push --tags`
  end

  desc 'Prompt for git tag to deploy'
  task :get_deploy_tag do
    avail_tags = `git tag --sort=version:refname | tail -n15`
    set :branch, (ENV['CATALYST_RELEASE'] || ask("release tag or branch:\n#{avail_tags}", avail_tags.chomp.split("\n").last))
  end
end
