Puppet::Type.type(:gsdefaults).provide(:defaults) do
  desc "gsdefaults provider using the 'defaults' tool to manage GNUstep defaults."

  commands :sudocmd => "sudo"
  commands :defaultscmd => "defaults"

  def create
    sudocmd('-u', @resource.value(:user), "defaults", "write", "#{@resource.value(:domain)}", "#{@resource.value(:key)}", "#{@resource.value(:value)}")
  end

  def destroy
    sudocmd('-u', @resource.value(:user), "defaults", "delete", "#{@resource.value(:domain)}", "#{@resource.value(:key)}")
  end

  def exists?
    begin
      cmdresult = sudocmd('-u', @resource.value(:user), "defaults", "read", "#{@resource.value(:domain)}", "#{@resource.value(:key)}")
    rescue Puppet::ExecutionFailure
      false
    end
  end
end
