function ig_learning_experiments_setup_env() {
  local scriptname="${(%):-%x}"
  local scriptdir="$(dirname "$scriptname")"
  local setupdir="$(cd "$scriptdir" && pwd)"

  source $setupdir/devel/setup.zsh

  # . src/gazebo-room-with-furniture/setup.bash
  gazebo_room_with_furniture_setupdir=$setupdir/src/gazebo-room-with-furniture
  {
    [ -f /usr/share/gazebo-9/setup.sh ] && source /usr/share/gazebo-9/setup.sh
    [ -f $gazebo_room_with_furniture_setupdir/gazebo_models/setup.bash ] && source $gazebo_room_with_furniture_setupdir/gazebo_models/setup.bash
    unset GAZEBO_MODEL_URI
  }

  export GAZEBO_MODEL_PATH="$gazebo_room_with_furniture_setupdir/models:$GAZEBO_MODEL_PATH"
  [ -f $gazebo_room_with_furniture_setupdir/envrc ] && source $gazebo_room_with_furniture_setupdir/envrc
  if [ -z "$IKEA_MODELS_DATASET_DIR" ]; then
    echo "Please download set IKEA_MODELS_DATASET_DIR from http://ikea.csail.mit.edu/zip/IKEA_models.zip"
  fi
  export GAZEBO_RESOURCE_PATH=$IKEA_MODELS_DATASET_DIR:$GAZEBO_RESOURCE_PATH

  # . src/ig_learning_experiments/setup.bash
  while read LINE
    do eval "export $LINE"
  done < $setupdir/src/ig_learning_experiments/envrc

}

ig_learning_experiments_setup_env
