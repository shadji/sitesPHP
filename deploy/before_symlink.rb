# User and group for creating 
user = "deploy"
group = "apache"
mode = "0770"
basepath = node[:nfs_client][:nfs_mount_point]
 
node[:sites].each do |site|
	site.directories.each do |directory, link|
		Chef::Log.info("Createing directory, if don't exisits")
		Chef::Log.info(`sudo mkdir -p #{basepath}/#{link}`)
		Chef::Log.info(`sudo chown #{user}:#{group} #{basepath}/#{link}`)
		Chef::Log.info(`sudo chmod #{mode} #{basepath}/#{link}`)
		Chef::Log.info(`sudo chmod g+s #{basepath}/#{link}`)
		Chef::Log.info("Createing symlink: sudo -H -u #{user} bash -c 'cd #{release_path} && ln -s #{basepath}/#{link} ./#{site.name}/#{directory}")
		Chef::Log.info(`sudo -H -u #{user} bash -c 'cd #{release_path} && ln -s #{basepath}/#{link} ./#{site.name}/#{directory}'`)
		raise "Symlink failed, server wonn't come up" unless $?.success?
	end
end