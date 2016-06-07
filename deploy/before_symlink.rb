# User and group for creating 
user = "deploy"
group = "apache"
mode = "0775"
basepath = node[:nfs_client][:nfs_mount_point]
 
node[:sites].each do |site|
	site[:directories].each do |directory|
		Chef::Log.info("Createing source directory, if don't exisits")
		Chef::Log.info(`sudo mkdir -p #{basepath}/#{directory[:storage_source]}`)
		Chef::Log.info(`sudo chown #{user}:#{group} #{basepath}/#{directory[:storage_source]}`)
		Chef::Log.info(`sudo chmod #{mode} #{basepath}/#{directory[:storage_source]}`)
		Chef::Log.info("Createing target directory, if don't exisits")		
		Chef::Log.info(`sudo -H -u #{user} bash -c 'cd #{release_path} && mkdir -p ./#{site.name}/#{directory[:local_path]}/#{directory[:link_name]}'`)
		Chef::Log.info("Createing symlink: sudo -H -u #{user} bash -c 'cd #{release_path} && ln -s #{basepath}/#{directory[:storage_source]} ./#{site.name}/#{directory[:local_path]}/#{directory[:link_name]}")
		Chef::Log.info(`sudo -H -u #{user} bash -c 'cd #{release_path} && ln -s #{basepath}/#{directory[:storage_source]} ./#{site.name}/#{directory[:local_path]}/#{directory[:link_name]}'`)
		raise "Symlink failed, server wonn't come up" unless $?.success?
	end
end