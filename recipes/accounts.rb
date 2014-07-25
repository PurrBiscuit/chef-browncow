node.browncow_users.each do |username|  
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
    source "keys.erb"
    owner username
    group username
    mode "0600"
    if username == 'app'
      variables(keys: node.deploy_keys)
    else
      variables(keys: node.browncow_keys)
    end
  end
end