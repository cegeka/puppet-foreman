# These facter facts return the value of the Puppet vardir and environment path
# settings for the node running puppet or puppet agent.  The intent is to
# enable Puppet modules to automatically have insight into a place where they
# can place variable data, or for modules running on the puppet server to know
# where environments are stored.
#
# The values should be directly usable in a File resource path attribute.
#
begin
  require 'facter/util/sssd'
rescue LoadError => e
  # puppet apply does not add module lib directories to the $LOAD_PATH (See
  # #4248). It should (in the future) but for the time being we need to be
  # defensive which is what this rescue block is doing.
  rb_file = File.join(File.dirname(__FILE__), 'util', 'sssd.rb')
  load rb_file if File.exist?(rb_file) || raise(e)
end

if defined? Facter::Util::Sssd
  # == Fact: ipa
  Facter.add(:ipa, :type => :aggregate) do
    {
      :default_realm => 'global/realm',
      :default_server => 'global/server',
    }.each do |key, path|
      chunk(key) do
        val = Facter::Util::Sssd.ipa_value(path)
        {key => val} if val
      end
    end
  end

  # == Fact: sssd
  Facter.add(:sssd, :type => :aggregate) do
    {
      :services => 'target[.="sssd"]/services',
      :ldap_user_extra_attrs => 'target[.=~regexp("domain/.*")][1]/ldap_user_extra_attrs',
      :allowed_uids => 'target[.="ifp"]/allowed_uids',
      :user_attributes => 'target[.="ifp"]/user_attributes',
    }.each do |key, path|
      chunk(key) do
        val = Facter::Util::Sssd.sssd_value(path)
        {key => val} if val
      end
    end

  end
end
