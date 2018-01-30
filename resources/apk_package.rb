resource_name :apk_package
provides :package, platform: 'alpine'

property :package_name, String, name_property: true

property :repository, String
property :allow_untrusted, [true, false], default: false
property :use_cache, [true, false], default: true
property :purge, [true, false], default: false

args = ''

args += "-X #{repository} " if property_is_set?(:repository)
args += '--allow-untrusted ' if allow_untrusted
args += '--no-cache ' unless use_cache
args += '--purge ' if purge

default_action :install

action :install do
    shell_out!("apk add #{package_name} #{args}")
end

action :upgrade do
    shell_out!("apk add --upgrade #{package_name} #{args}")
end

action :nothing do
end

action :remove do
    shell_out!("apk del #{package_name} #{args}")
end

action :fetch do
    shell_out!("apk fetch #{package_name} #{args}")
end
