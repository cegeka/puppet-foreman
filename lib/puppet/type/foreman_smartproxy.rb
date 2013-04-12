Puppet::Type.newtype(:foreman_smartproxy) do
  desc 'foreman_smartproxy creates a smartproxy in foreman database.'

  ensurable

  newparam(:name, :namevar => true) do
    desc 'The name of the smartproxy.'
  end

  newparam(:base_url) do
    desc 'Foreman\'s base_url.'
  end

  newparam(:consumer_key) do
    desc 'Foreman oauth consumer_key'
  end

  newparam(:consumer_secret) do
    desc 'Foreman oauth consumer_secret'
  end

  newproperty(:url) do
    desc 'The url of the smartproxy'
    isrequired
    newvalues(URI.regexp)
  end

end

