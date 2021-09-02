# SYNOPSIS

Outthentic plugin.

Execute parallel copy files on servers via scp.

For searching by mask using /etc/hosts.

# INSTALL

    $ sparrow plg install bash-pscp

# USAGE
## Manually
    
    $ sparrow plg run bash-pscp --param files="/etc/hosts"  --param destination='194.87.235.183:/etc/hosts 193.124.178.59:~/ my-*-host:~/'

## via sparrowdo

    
    task-run  %(
      task        => 'copy /etc/hosts',
      plugin      => 'bash-pscp',
      parameters  => %( 
       files        => '/etc/hosts', 
       destination => '194.87.235.183:/etc/hosts 193.124.178.59:~/ my-*-host:/tmp',
      )
    );

# Parameters

## files

Your files.

## destination

Your desired hosts and dir on remote machines.

## user

Name of user on remote machines.

Default is your `$USER` variable.

## quiet

Flag for ssh quiet option.

Default is `false`.
