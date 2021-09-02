set_spl %( dev-bash-pscp => 'https://github.com/Spigell/bash-pscp' );

task-run 'multi hosts', 'dev-bash-pscp', %(
  files => '/etc/hosts',
  destination => '127.0.0.1:/tmp/hosts_1 my-*-host:~/',
  quiet => 'false',
  user  => 'vagrant'
);

bash 'ls -alht ~/hosts';
bash 'ls -alht /tmp/hosts_1';
