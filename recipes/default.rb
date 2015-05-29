include_recipe "apt"
include_recipe "ruby"
include_recipe "curl"
include_recipe "apache2"
include_recipe "git"
include_recipe "purrbiscuit::accounts"
include_recipe "purrbiscuit::deploy"
include_recipe "purrbiscuit::hostsfile"
include_recipe "purrbiscuit::newrelic" unless Chef::Config[:solo]
