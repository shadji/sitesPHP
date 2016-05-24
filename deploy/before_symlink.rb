user = "apache"
group = "apache"
mode = "0760"

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

for site in sites
	Chef::Log.info("Createing directory, if don't exisits")
	Chef::Log.info(`sudo mkdir -p #{site.link}`)
	Chef::Log.info(`sudo chown #{user}:#{group} #{site.link}`)
	Chef::Log.info(`sudo chmod #{mode} #{site.link}`)
	Chef::Log.info(`sudo chmod g+s #{site.link}`)
	Chef::Log.info("Createing symlink: sudo -H -u #{user} bash -c 'cd #{release_path} && ln -s #{site.link} ./#{site.name}/#{site.directory}")
	Chef::Log.info(`sudo -H -u #{user} bash -c 'cd #{release_path} && ln -s #{site.link} ./#{site.name}/#{site.directory}'`)
	raise "Symlink failed, server wonn't come up" unless $?.success?
end

