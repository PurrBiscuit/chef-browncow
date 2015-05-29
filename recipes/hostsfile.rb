#Add the virtual machine IP with server names for app to hostsfile for vagrant
if Chef::Config[:solo]
	hostsfile_entry '192.168.50.4' do
		hostname 'purrbiscuit.com'
		action :create
	end
end