resource_name :dotnet_install
property :message, String, name_property: true
property :version, String, default: '' # if nil, defaults to latest
property :location, String, default: "#{node['dotnet']['location']}"

load_current_value do
  if ::File.exists?("#{location}")
    puts "Service Previous Installed - #{location}"
  end
end

action :install do
    case node['platform']
    when "centos", "oracle"

      package ['libunwind', 'libicu'] do
        action :install
      end

      remote_file location do
        source 'https://go.microsoft.com/fwlink/?LinkID=835019'
        action :create
      end

      directory "/opt/dotnet" do
      end

      #extract the cookbook using terminal, do not to include the tar file cookbook
      execute "extracting cookbook" do
        command "tar -xvf #{location} -C /opt/dotnet/"
      end

      link '/usr/local/bin/dotnet' do
        to '/opt/dotnet/dotnet'
        link_type :symbolic
        action :create
      end
    end
end
