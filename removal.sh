#! /bin/bash
mapfile -t exceptions < exceptions.txt

if [[ -z "$FOLDER_PATH" ]]; then
    echo "Must provide FOLDER_PATH in environment variable" 1>&2
    exit 1
fi


for i in "$@"; do
  case $i in
    -e|--echo)
      ECHO=YES
      shift
      ;;
    -x|--execute)
      EXECUTE=YES
      shift
      ;;
    *)
      # unknown option
      ;;
  esac
done

for i in "${exceptions[@]}"
do
  arguments=${arguments}" -not ( -path ${FOLDER_PATH}/$i -prune )"
done

if [[ ! -z "$ECHO" ]] ; then
  echo "Testing mode - folders to be removed:"
  find ${FOLDER_PATH} -maxdepth 1 -mtime +30 -type d $arguments -exec echo {} \;
fi

if [[ ! -z "$EXECUTE" ]] ; then
  echo "Execution mode - removing folders:"
  find ${FOLDER_PATH} -maxdepth 1 -mtime +30 -type d $arguments -exec sudo rm -rf {} \;
fi

