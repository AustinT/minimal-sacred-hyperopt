# Set up variables and directories for mongodb
##########
export MONGO_DIR="mongodb"
export MONGO_DATA_DIR="$MONGO_DIR/data"
export MONGO_LOG_PATH="$MONGO_DIR/log"
export MONGO_LOG_FILE="$MONGO_LOG_PATH/mongo.log"
export MONGO_PORT="27184" # A custom port for this experiment
export MONGO_WRITE_IP="localhost" # Which IP address will be written to
export MONGO_IP_LIST="$MONGO_WRITE_IP" # Add to this if necessary

# Create logging directories
mkdir -p $MONGO_DATA_DIR $MONGO_LOG_PATH

# Alias a command to launch mongo
alias mdb="mongod --dbpath=$MONGO_DATA_DIR --logpath=$MONGO_LOG_FILE --logappend --bind_ip=$MONGO_IP_LIST --port=$MONGO_PORT"
alias mongo_default="mongo --host $MONGO_WRITE_IP --port $MONGO_PORT"

# Shortcut to completely clear a mongo database (useful for testing)
function clear_db {
    mongo --port "$MONGO_PORT" --host "$MONGO_WRITE_IP" "$1" --eval "printjson(db.dropDatabase())"
}

# Function to show which databases exist right now
function show_dbs {
    mongo --port "$MONGO_PORT" --host "$MONGO_WRITE_IP" "$1" --eval "printjson(db.adminCommand('listDatabases'))"
}

# Alias command to launch omniboard
function obd {
    omniboard -m "$MONGO_WRITE_IP:$MONGO_PORT:$1"
}

# Common args for hyperopt
HYPEROPT_COMMON_ARGS="--poll-interval 15 --workdir ."
