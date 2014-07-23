include_recipe "apt"
include_recipe "ruby"
include_recipe "curl"
include_recipe "apache2"
include_recipe "git"
include_recipe "browncow::accounts"

deploy_dir      = node.deploy_dir
web_dir         = "#{deploy_dir}/current"
shared_dir      = "#{deploy_dir}/shared"
app_name        = node.apache.app_name
deploy_username = node.deploy_user.username

# Install system packages
%w{git sendmail}.each do |package_name|
  package package_name do
    action :install
  end
end

# Install apache related packages
%w{php5-mysql php5-pgsql php-apc php5-curl}.each do |package_name|
  package package_name do
    action :install
    notifies :restart, "service[apache2]"
  end
end

# Create deploy directory
directory deploy_dir do
  owner deploy_username
  group deploy_username
  mode 00754
  recursive true
  action :create
end

# Create shared directory
directory shared_dir do
  owner deploy_username
  group deploy_username
  action :create
end

# Add Apache user to deploy group
group deploy_username do
  action :modify
  members "www-data"
end

# Configure application vhost
template "#{node.apache.dir}/sites-available/#{app_name}.conf" do
  source "#{app_name}.conf.erb"
  mode 0644
  owner "root"
  group "root"
  variables({
    log_dir:        node.apache.log_dir,
    server_name:    node.apache.server_name,
    web_dir:        web_dir,
    indexes:        node.apache.indexes,
    allow_override: node.apache.override
  })
  notifies :restart, "service[apache2]"
end

# Enable site (equivalent of a2ensite)
apache_site "#{app_name}.conf" do
  enable true
end