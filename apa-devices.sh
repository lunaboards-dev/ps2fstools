if lua apa_parts.lua $1 > /dev/null; then
	declare -i dev_n=0
	declare dev=${1#/dev/}
	rm /dev/sde?*
	IFS=$'\n'
	for e in $(dmsetup ls | grep "${dev//[^[:alnum:]]/_}""-apa-" | awk '{ print $1 }'); do
		dmsetup remove "$e"
	done
	for e in $(lua apa_parts.lua $1); do
		((dev_n=$dev_n+1))
		# echo $dev$dev_n;
		lua gen_dm_table.lua $1 $e | dmsetup create "${dev//[^[:alnum:]]/_}-apa-${e//[^[:alnum:]]/_}";
		echo "${dev//[^[:alnum:]]/_}-apa-${e//[^[:alnum:]]/_}"
		ln -s /dev/mapper/"${dev//[^[:alnum:]]/_}-apa-${e//[^[:alnum:]]/_}" "/dev/$dev$dev_n"
	done
	unset IFS
fi