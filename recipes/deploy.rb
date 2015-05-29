deploy_username = node.deploy_user.username

# Create deploy directory
directory node.deploy_dir do
  owner deploy_username
  group deploy_username
  mode 00754
  recursive true
  action :create
end

# Create shared directory
directory "#{node.deploy_dir}/shared" do
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
template "#{node.apache.dir}/sites-available/#{node.apache.app_name}.conf" do
  source "#{node.apache.app_name}.conf.erb"
  mode 0644
  owner "root"
  group "root"
  variables(
  	server_name:    node.apache.app_name,  
    web_dir:        "/var/www/purrbiscuit.com/current",
    indexes:        node.apache.indexes,
    allow_override: node.apache.override
  )
  notifies :restart, "service[apache2]"
end 

# Enable site (equivalent of a2ensite)
apache_site "#{node.apache.app_name}" do
  enable true
end
