resource_name :dotnet_install
property :message, String, name_property: true
property :version, String, default: '' # if nil, defaults to latest
property :location, String, default: '/opt/dotnet.tar.gz'
property :download_link, String, default: "#{node['dotnet']['download']['link']}#{node['dotnet']['download']["#{node['platform']}"]["#{node['platform_version'][0]}"]}"

load_current_value do
    if ::File.exist?(location.to_s)
        puts "Service Previous Installed - #{location}"
    end
end

action :install do
    directory "/opt/dotnet" do
      action :create
    end

    case node['platform_family']
    when 'debian'
        case node['platform']
        when 'debian'
            package %(curl libunwind8 gettext) do
                action :install
            end

            remote_file location do
              source download_link
              action :create
            end

            # extract the cookbook using terminal, do not to include the tar file cookbook
            execute 'extracting cookbook' do
                command "tar -xvf #{location} -C /opt/dotnet/"
            end

            link '/usr/local/bin/dotnet' do
                to '/opt/dotnet/dotnet'
                link_type :symbolic
                action :create
            end
        when 'ubuntu'
            # TODO
        end

    when 'rhel'
        case node['platform']
        when 'centos', 'fedora', 'oracle'
            package %w(libunwind libicu) do
                action :install
            end

            remote_file location do
              source download_link
              action :create
            end

            # extract the cookbook using terminal, do not to include the tar file cookbook
            execute 'extracting cookbook' do
                command "tar -xvf #{location} -C /opt/dotnet/"
            end

            link '/usr/local/bin/dotnet' do
                to '/opt/dotnet/dotnet'
                link_type :symbolic
                action :create
            end
        when 'redhat'
            execute 'enable .net core channel' do
                command 'subscription-manager repos --enable=rhel-7-server-dotnet-rpms'
            end

            package %w(scl-utils rh-dotnetcore10) do
                action :install
            end

            execute 'enable rh-dotnetcore10' do
                command 'scl enable rh-dotnetcore10 bash'
            end
        end
    end
end
