
class Site
	attr_accessor :name, :directory, :link
end

site1 = Site.new
site1.name = "site1"
site1.directory = "images"
site1.link = "/mnt/nfs/site1"

site2 = Site.new
site2.name = "site2"
site2.directory = "images"
site2.link = "/mnt/nfs/site2"

sites = [site1, site2]

ruby_block "Sym link creation" do
	for site in sites	
		Chef::Log.info("Symlink cd #{release_path} && ln -s #{site.link} ./#{site.name}/#{site.directory}")
		Chef::Log.info(`cd #{release_path} && ln -s #{site.link} ./#{site.name}/#{site.directory}`)
		raise "Symlink failed, server wonn't come up" unless $?.success?
	end
end
