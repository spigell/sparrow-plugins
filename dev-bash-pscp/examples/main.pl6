set_spl %( dev-bash-pscp => 'https://github.com/Spigell/bash-pscp' );

task-run 'main test', 'dev-bash-pscp', %(
  files => '/etc/hosts',
  destination => '127.0.0.1:~/',
  quiet => 'false',
  user  => 'vagrant'
);

bash 'ls -alht ~/hosts';
