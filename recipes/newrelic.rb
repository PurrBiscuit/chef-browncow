databag = Chef::EncryptedDataBagItem.load("credentials", "newrelic")
node.default.newrelic.server_monitoring.license = databag['license_key']

include_recipe "newrelic::server-monitor-agent"
