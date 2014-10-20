Puppet::Type.newtype(:gsdefaults) do
  @doc = "Manage GNUstep defaults"
  ensurable


  newparam(:name) do
    desc "The resource name."
    isnamevar
  end

  newparam(:user) do
    desc "The user we want to manage the default, defaults to \"root\""
    defaultto {
      if value == nil 
        "root"
      else
        autorequire(:user) do
          [ value ]
        end
      end
    }
  end

  newparam(:domain) do
    desc "The application domain in which to manage the default, defaults to \"NSGlobalDomain\""
    defaultto "NSGlobalDomain"
  end

  newparam(:key) do
    desc "The key to manage in the specified domain, mandatory parameter"
  end

  newparam(:value) do
    desc "The value to set for the given key in the specified domain. Mandatory when ensure => present."
  end
end
