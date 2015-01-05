Puppet::Type.newtype(:gsdefaults) do
  @doc = "Manage GNUstep defaults"
  ensurable do
    desc "Create a given entry in a GNUstep domain for a given user.
      Valid values are 'present', 'absent', and 'keyonly'.
      'present' will create the key, with the given value, 'absent'
      will remove the value. 'keyonly' will set the value, if the key
      is not given yet, otherwise won't update the value, in case
      it's different."

    defaultvalues
    defaultto :present

    newvalue(:keyonly) do
      provider.keyonly
    end

    def retrieve
      prov = @resource.provider
      if prov.keyvalue_exists?
        retval = :present
      else 
        if prov.keyonly_exists?
          retval = :keyonly
        else 
          retval = :absent
        end
      end
      return retval
    end

    def insync?(is)
      @should ||= []
      case should
      when :present
        return true unless [ :absent, :keyonly ].include?(is)
      when :keyonly
        return true unless [ :absent ].include?(is)
      when :absent
        return true unless [ :present, :keyonly ].include?(is)
      end
    end
  end

  newparam(:name) do
    desc "The resource name."
    isnamevar
  end

  newparam(:user) do
    desc "The user we want to manage the default, defaults to \"root\""
    defaultto do
      if value == nil 
        "root"
      else
        autorequire(:user) do
          [ value ]
        end
      end
    end
  end

  newparam(:domain) do
    desc "The application domain in which to manage the default, defaults to \"NSGlobalDomain\""
    defaultto "NSGlobalDomain"
  end

  newparam(:key) do
    desc "The key to manage in the specified domain, mandatory parameter"
  end

  newparam(:value) do
    desc "The value to set for the given key in the specified domain. Mandatory when ensure => \"present\" or \"keyonly\"."
  end
  
end
