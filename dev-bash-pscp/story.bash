debug=$(config debug)

[[ $debug ]] && set -x

destinations=$(config destination)
files=$(config files)
user=$(config user)
ssh_quiet=$(config quiet)

[[ -z $user ]] && user=$USER

[[ $ssh_quiet == true ]] && ssh_quiet_option=" -q"

for destination in $destinations; do
hosts_list=""
hosts=$(echo $destination | cut -f 1 -d ":")
destionation_dir=$(echo $destination | cut -f 2 -d ":")

for host in $hosts; do
  host_pattern=`echo $host | sed 's/\./\\\./g' | sed 's/*/[-.[:alnum:]]*/g' | sed 's/?/./g'`
  search_results=`grep -Ev '^#' /etc/hosts | grep -o "\<${host_pattern}\>" `
  if [[ "$search_results" == "" ]] ; then
    hosts_list+=" $host"
  else
    hosts_list+=" $search_results"
  fi
done


hosts_list=`echo $hosts_list | sed 's/[[:space:]]/\n/g' | sort -u`

for host_exclude in $hosts_exclude; do
  hosts_list=`echo $hosts_list | sed "s/"$host_exclude"//g"`
done

pids=()
for host in $hosts_list ; do
	# scp /etc/hosts 127.0.0.1:~/
  for file in $files; do 
 script -q -c "scp $ssh_quiet_option -o LogLevel=ERROR -o UserKnownHostsFile=/dev/null -o PasswordAuthentication=no -o StrictHostKeyChecking=no -o ConnectTimeout=10 $file $user@$host:$destionation_dir " /dev/null &
  done
  pids[${#pids[*]}]=$!
	{
		while [[ -e /proc/$$ ]] ; do sleep 1s; done;
	kill -9 $! 2>/dev/null
	 }&
done
done
i=0
for host in $hosts_list ; do
	[[ -e /proc/${pids[$i]} ]] &&

	wait ${pids[$i]}


	i=$(( $i + 1 ))
done
