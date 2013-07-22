namespace :db do
  def command_args(config)
    abort "Missing database name" if config['database'].blank?
 
    args = ''
    args << "-u #{config['username']} " if config['username'].present?
    args << "-p#{config['password']} " if config['password'].present?
    args << config['database']
  end
 
  task :load_live_data do
    config = Rails.application.config.database_configuration
 
    abort "Missing Main developement db config" if config['development_main'].blank?
 
    dev  = config['development']
    live = config['development_main']
 
    abort "Dev db is not mysql" unless dev['adapter'] =~ /mysql/
    abort "Live db is not mysql" unless live['adapter'] =~ /mysql/
    abort "Missing ssh host" if live['host'].blank?
 
    cmd  = "ssh -C "
    cmd << "#{live['ssh_user']}@" if live['ssh_user'].present?
    cmd << "#{live['host']} mysqldump #{command_args(live)} | "
    cmd << "mysql #{command_args(dev)}"
 
    `#{cmd}`
  end
end