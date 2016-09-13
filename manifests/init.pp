#
# Boostrap class to push standard tools and configuration on to managed hosts.
# @author jonty.bale@dwp.gsi.gov.uk
#
class bootstrap
{

    # require freepuppet
    include freepuppet

    # ensure librarian-puppet is installed
    package { 'rubygems-integration':
        ensure => present
    }
    package { 'librarian-puppet':
        ensure   => present,
        provider => gem,
        require  => Package['rubygems-integration']
    }

    # ensure everyones running off AWS standard time servers
    class { '::ntp':
        servers       => [
            '0.amazon.pool.ntp.org',
            '1.amazon.pool.ntp.org',
            '2.amazon.pool.ntp.org',
            '3.amazon.pool.ntp.org'
        ],
        iburst_enable => true
    }
}