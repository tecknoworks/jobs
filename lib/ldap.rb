require 'net-ldap'

# Example usage:
#
# Ldap.new.valid?('name@tecknoworks.com', 'password')
#
class Ldap
  def initialize(options = {})
    options[:user] ||= ENV['JOBS_LDAP_USER'] # if options[:user].blank?
    options[:pass] ||= ENV['JOBS_LDAP_PASS'] # if options[:pass].blank?
    options[:host] ||= ENV['JOBS_LDAP_HOST'] # if options[:host].blank?
    options[:base_dn] ||= ENV['JOBS_LDAP_BASE_DN'] # if options[:base_dn].blank?
    @options = options
  end

  # TODO: error handling sucks here. sorry
  def valid?(username, password)
    return false if credentials_empty? username, password

    user_dn = user_exists?(username)
    ldap = auth_user user_dn, password
    ldap.bind
  rescue Net::LDAP::LdapError
    false
  end

  private

  def auth_user(username, password)
    ldap_connection username, password
  end

  def user_exists?(username)
    ldap = ldap_connection(construct_dn(@options[:user]), @options[:pass])

    user = nil
    ldap.search(base: @options[:base_dn], attributes: %w(dn mail)) do |entry|
      user = entry[:dn][0] if entry[:mail][0] == username
    end

    user
  end

  def ldap_connection(username, password)
    ldap = Net::LDAP.new
    ldap.host = @options[:host]
    ldap.authenticate username, password
    ldap
  end

  def construct_dn(username)
    "cn=#{username},#{@options[:base_dn]}"
  end

  def credentials_empty?(username, password)
    username.empty? || password.empty?
  end
end
