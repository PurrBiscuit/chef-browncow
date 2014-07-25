include_recipe "apt"
include_recipe "ruby"
include_recipe "curl"
include_recipe "apache2"
include_recipe "git"
include_recipe "browncow::accounts"
include_recipe "browncow::deploy"
include_recipe "browncow::hostsfile"

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