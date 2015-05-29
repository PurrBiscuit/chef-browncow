name             'purrbiscuit'
maintainer       'Stephen Purr'
maintainer_email 'steve@purrbiscuit.com'
license          'All rights reserved, preserved and you-got-served'
description      'Configures the purrbiscuit server on EC2'
long_description 'Configuration for PurrBiscuit servers'
version          '0.3.1'

depends "apt"
depends "ruby"
depends "curl"
depends "apache2"
depends "git"
depends "hostsfile"
depends "newrelic", "1.3.0"