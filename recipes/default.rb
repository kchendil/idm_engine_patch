#
# Cookbook Name:: idm_engine_patch
# Recipe:: default
#
# Copyright 2013, Chendil Kumar Manoharan
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


engine_patch_build_loc=node['idm_engine_patch']['patch_url']


execute "Download the Patch" do
 user "root" 
 command "mkdir -p /tmp/engine-patch; wget -nd -r -P /tmp/engine-patch -A rpm #{engine_patch_build_loc}"
 not_if { ::File.exists?("/tmp/engine-patch/novell-DXMLbasenoarch.rpm")}
 #Do not execute if all the rpms are present
  action :run
end

execute "Install the patch" do
 user "root" 
 command "cd /tmp/engine-patch; rpm -Uvh /tmp/engine-patch/*.rpm" 
 not_if { ::File.exists?("/tmp/engine-patch/cd-image/patch/Linux/engine/64-bit/novell-DXMLbasenoarch.rpm")}
 #If the RPM is not upgraded do not execute this, need to check the rpm versions
  action :run
end


execute "Restart ndsd" do
 user "root"
 command "/etc/init.d/ndsd restart" 
 not_if { ::File.exists?("/tmp/engine-patch/cd-image/patch/Linux/engine/64-bit/novell-DXMLbasenoarch.rpm")}
 #If the RPM is not upgraded do not execute this, need to check the rpm versions
  action :run
end

