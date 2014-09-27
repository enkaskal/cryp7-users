## first config deps
# sudo
default['authorization']['sudo']['include_sudoers_d'] = true
default['authorization']['sudo']['passwordless'] = true
# FIXME - refactor to use if (test | aws | vagrant | etc )
default['authorization']['sudo']['users'] = ['vagrant', 'ubuntu']

# finally, config this
default['cryp7_users']['groups'] = ['sysadmin', 'cryp7']

#e0f

