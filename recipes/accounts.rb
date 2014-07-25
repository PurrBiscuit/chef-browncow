deploy_keys = node.deploy_keys

node.users.each do |username|  
  group username do
    action :create
  end

  user username do 
    action :create
    home "/home/#{username}"
    shell "/bin/bash"
    gid username
  end

  %W{ /home/#{username} /home/#{username}/.ssh }.each do |dir|
    directory dir do 
      owner username
      group username
      action :create
      recursive true
    end
  end

  template "/home/#{username}/.ssh/authorized_keys" do 
    source "username.erb"
    owner username
    group username
    mode "0600"
    variables(keys: deploy_keys)
  end
end