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
      currvalue = cmdresult.split[2..-1].join(' ')
      if currvalue == true
        currvalue = 'YES'
      end
      if currvalue.gsub(/\s+/, "").gsub(/['"]/,"") == @resource.value(:value).gsub(/\s+/, "").gsub(/['"]/,"")
        true
      else
        Puppet.notice("replacing old value: #{currvalue} with new value: #{@resource.value(:value)}")
        false
      end
    rescue Puppet::ExecutionFailure
      false
    end
  end
end
