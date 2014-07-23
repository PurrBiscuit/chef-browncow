deploy_keys = node.deploy_keys

  group "app" do
    action :create
  end

  user "app" do 
    action :create
    home "/home/app"
    shell "/bin/bash"
    gid "app"
  end

  [ "/home/app", "/home/app/.ssh" ].each do |dir|
    directory dir do 
      owner "app"
      group "app"
      action :create
      recursive true
    end
  end

  template "/home/app/.ssh/authorized_keys" do 
    source "app.erb"
    owner "app"
    group "app"
    mode "0600"
    variables(keys: deploy_keys)
  end