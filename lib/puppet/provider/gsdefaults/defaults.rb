Puppet::Type.type(:gsdefaults).provide(:defaults) do
  desc "gsdefaults provider using the 'defaults' tool to manage GNUstep defaults."

  commands :sudocmd => "sudo"
  commands :defaultscmd => "defaults"

  def create
    sudocmd('-u', @resource.value(:user), "defaults", "write", "#{@resource.value(:domain)}", "#{@resource.value(:key)}", "#{@resource.value(:value)}")
  end
  def keyonly
    self.create
  end

  def destroy
    sudocmd('-u', @resource.value(:user), "defaults", "delete", "#{@resource.value(:domain)}", "#{@resource.value(:key)}")
  end

  def read_key
    begin
      sudocmd('-u', @resource.value(:user), "defaults", "read", "#{@resource.value(:domain)}", "#{@resource.value(:key)}", "2>/dev/null")
    rescue Puppet::ExecutionFailure
      false
    end
  end

  def exists?
    keyvalue_exists? || keyonly_exists?
  end

  def keyonly_exists?
    cmdresult = read_key
    return false unless cmdresult
    if cmdresult.size > 0
      return true
    else
      return false
    end
  end

  def keyvalue_exists?
    cmdresult = read_key
    return false unless cmdresult
    currvalue = cmdresult.split[2..-1].join(' ')
    puts currvalue
    if currvalue == true
      currvalue = 'YES'
    end
    if currvalue.gsub(/\s+/, "").gsub(/['"]/,"") == @resource.value(:value).gsub(/\s+/, "").gsub(/['"]/,"")
      return true
    else
      return false
    end
  end

end
