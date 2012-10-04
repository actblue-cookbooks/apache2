apache_module "disk_cache" do 
  conf true
end

# the disk cache cleaner seems to have some problems. This is a hack
# to enable some manual rm'ing to help it along. Debugging it more
# properly is beyond me, but I can't really deal with it eating it's
# inodes like this.
if(not node[:apache][:disk_cache][:rm_older_than].empty?)
  cron "apace remove old disk cache" do
    command %{find #{node[:apache][:cache_dir]}/mod_disk_cache -type f -a -mtime #{node[:apache][:disk_cache][:rm_older_than]} -a -print0 | xargs -0 rm -rf && find #{node[:apache][:cache_dir]}/mod_disk_cache -mindepth 1 -type d -empty -print0 | xargs -0 rm -rf}
    hour 1
    minute 30
    user "root"
    mailto "admin@actbluetech.com"
  end
end
