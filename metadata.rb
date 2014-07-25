name             'browncow'
maintainer       'Stephen Purr'
maintainer_email 'spurr@articulate.com'
license          'All rights reserved, preserved and you-got-served'
description      'Configures the browncow server on EC2'
long_description 'Configuration for Browncow Inc servers'
version          '0.3.0'

%w{ apt ruby curl apache2 git hostsfile }.each do |cookbook|
  depends cookbook
end