for e in $(find "$1"); do
	if [[ -d "$e" ]]; then
		ps3mca-tool -mkdir "$2/$e"
	else
		ps3mca-tool -in "$e" "$2/$e"
	fi
done