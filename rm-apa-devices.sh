declare dev=${1#/dev/}
for e in $(dmsetup ls | grep "${dev//[^[:alnum:]]/_}""-apa-" | awk '{ print $1 }'); do
	dmsetup remove $e
done