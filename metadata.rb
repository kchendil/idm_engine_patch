name             "idm_engine_patch"
maintainer       "Chendil Kumar Manoharan"
maintainer_email "kchendil@netiq.com"
license          "Apache 2.0"
description      "Installs IDM Engine Patch"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.11"


%w{ suse centos fedora ubuntu debian}.each do |os|
  supports os
end

recipe "idm_engine_patch::default", "Installs IDM engine Patch"