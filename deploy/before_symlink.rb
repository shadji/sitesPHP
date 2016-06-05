# User and group for creating 
user = "deploy"
group = "nfs-share"
mode = "0775"
basepath = node[:nfs_client][:nfs_mount_point]
 
node[:sites].each do |site|
	site[:directories].each do |directory|
		Chef::Log.info("Createing symlink: sudo -H -u #{user} bash -c 'cd #{release_path} && ln -s #{basepath}/#{directory[:link]} ./#{site.name}/#{directory[:directory]}")
		Chef::Log.info(`sudo -H -u #{user} bash -c 'cd #{release_path} && ln -s #{basepath}/#{directory[:link]} ./#{site.name}/#{directory[:directory]}'`)
		raise "Symlink failed, server wonn't come up" unless $?.success?
	end
end

	
