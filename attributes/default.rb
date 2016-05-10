#
# Cookbook Name:: apache2
# Attributes:: apache
#
# Copyright 2008-2009, Opscode, Inc.
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

# Where the various parts of apache are
case platform
when "redhat","centos","fedora","suse"
  set[:apache][:dir]     = "/etc/httpd"
  set[:apache][:log_dir] = "/var/log/httpd"
  set[:apache][:user]    = "apache"
  set[:apache][:binary]  = "/usr/sbin/httpd"
  set[:apache][:icondir] = "/var/www/icons/"
  set[:apache][:cache_dir] = "/var/cache/httpd"
when "debian","ubuntu"
  set[:apache][:dir]     = "/etc/apache2"
  set[:apache][:log_dir] = "/var/log/apache2"
  set[:apache][:user]    = "www-data"
  set[:apache][:binary]  = "/usr/sbin/apache2"
  set[:apache][:icondir] = "/usr/share/apache2/icons"
  set[:apache][:cache_dir] = "/var/cache/apache2"
when "arch"
  set[:apache][:dir]     = "/etc/httpd"
  set[:apache][:log_dir] = "/var/log/httpd"
  set[:apache][:user]    = "http"
  set[:apache][:binary]  = "/usr/sbin/httpd"
  set[:apache][:icondir] = "/usr/share/httpd/icons"
  set[:apache][:cache_dir] = "/var/cache/httpd"
else
  set[:apache][:dir]     = "/etc/apache2"
  set[:apache][:log_dir] = "/var/log/apache2"
  set[:apache][:user]    = "www-data"
  set[:apache][:binary]  = "/usr/sbin/apache2"
  set[:apache][:icondir] = "/usr/share/apache2/icons"
  set[:apache][:cache_dir] = "/var/cache/apache2"
end

###
# These settings need the unless, since we want them to be tunable,
# and we don't want to override the tunings.
###

# General settings
default[:apache][:listen_ports] = [80, 443]
default[:apache][:namevirtualhost_ports] = [80, 443]
default[:apache][:contact] = "ops@example.com"
default[:apache][:timeout] = 300
default[:apache][:keepalive] = "On"
default[:apache][:keepaliverequests] = 100
default[:apache][:keepalivetimeout] = 5
default[:apache][:namevirtualhost] = false

# Security
default[:apache][:servertokens] = "Prod"
default[:apache][:serversignature] = "On"
default[:apache][:traceenable] = "Off"
default[:apache][:block_range_header] = false


# mod_auth_openids
default[:apache][:allowed_openids] = Array.new

# Prefork Attributes
default[:apache][:prefork][:startservers] = 16
default[:apache][:prefork][:minspareservers] = 16
default[:apache][:prefork][:maxspareservers] = 32
default[:apache][:prefork][:serverlimit] = 400
default[:apache][:prefork][:maxclients] = 400
default[:apache][:prefork][:maxrequestsperchild] = 10000

# Worker Attributes
default[:apache][:worker][:startservers] = 4
default[:apache][:worker][:maxclients] = 1024
default[:apache][:worker][:minsparethreads] = 64
default[:apache][:worker][:maxsparethreads] = 192
default[:apache][:worker][:threadsperchild] = 64
default[:apache][:worker][:maxrequestsperchild] = 0

# mod cache related settings These are described in
# http://httpd.apache.org/docs/2.2/caching.html there are 64 allowed
# characters. A length of 1 means up o 64 children. A lengh of 2 means
# 4096. 1 is recommended.
#
# With the default settings of length=1, and levels=2, there is a
# total of 64^2=4096 subdirectories. If you assume a million cached
# files, that's about 250 files per firectory. Quite comfortable.
default[:apache][:disk_cache][:CacheDirLevels] = 2
default[:apache][:disk_cache][:CacheDirLength] = 1
default[:apache][:disk_cache][:htcacheclean_size] = "150M"
default[:apache][:disk_cache][:htcacheclean_interval] = 120
default[:apache][:disk_cache][:htcacheclean_options] = "-n -t"
# Since htcacheclean is somewhat broken, this enables a cron job to
# delete things older than X
default[:apache][:disk_cache][:rm_older_than] = ""
#
default[:apache][:mem_cache][:MCacheSize] = 4096
default[:apache][:mem_cache][:MCacheMaxObjectCount] = 100
default[:apache][:mem_cache][:MCacheMinObjectSize] = 1
default[:apache][:mem_cache][:MCacheMaxObjectSize] = 2048
