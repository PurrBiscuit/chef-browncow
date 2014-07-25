
web_dir         = "#{node.deploy_dir}/current"
shared_dir      = "#{node.deploy_dir}/shared"
deploy_username = node.deploy_user.username

# Create deploy directory
node.deploy_dir.each do |deploy_dir|
	  directory deploy_dir do
	    owner deploy_username
	    group deploy_username
	    mode 00754
	    recursive true
	    action :create
	  end

	# Create shared directory
	directory "#{deploy_dir}/shared" do
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
	node.apache.app_name.each do |app_name|
	  template "#{node.apache.dir}/sites-available/#{app_name}.conf" do
	    source "#{app_name}.conf.erb"
	    mode 0644
	    owner "root"
	    group "root"
	    variables({
	      log_dir:        node.apache.log_dir,
	      server_name:    app_name,
	      web_dir:        "browncow.com/current",
	      indexes:        node.apache.indexes,
	      allow_override: node.apache.override
	    })
	    notifies :restart, "service[apache2]"
	  end 
	# Enable site (equivalent of a2ensite)
		apache_site "#{app_name}.conf" do
		  enable true
		end
	end
end