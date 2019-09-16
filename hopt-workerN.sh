source setup_env.sh
echo "$1 $2"
if [ -z "$1" ]; then
    echo "ERROR! NO DATABASE ARGUMENT SUPPLIED!"
else
    PYTHONPATH="./$PYTHONPATH" hyperopt-mongo-worker $HYPEROPT_COMMON_ARGS --mongo="$MONGO_WRITE_IP:$MONGO_PORT/$1" --max-jobs="$2"
fi
