#!/usr/bin/env bash

set -e

################################################################################
# Finds out the script path.

# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-which-directory-it-is-stored-in
SCRIPT="${BASH_SOURCE[0]}"
while [ -h "$SCRIPT" ]; do # resolve $SCRIPT until the file is no longer a symlink
  SCRIPT_PATH="$( cd -P "$( dirname "$SCRIPT" )" && pwd )"
  SCRIPT="$(readlink "$SCRIPT")"
  # if $SCRIPT was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  [[ $SCRIPT != /* ]] && SCRIPT="$SCRIPT_PATH/$SCRIPT"
done
SCRIPT_PATH="$( cd -P "$( dirname "$SCRIPT" )" && pwd )"

################################################################################
# Sets and remembers IG_LEARNING_DATA_DIR.
input_ig_learning_data_dir=""

while [ -z "$input_ig_learning_data_dir" ]; do
  echo "Please input your desired IG_LEARNING_DATA_DIR, followed by [ENTER]:"
  read input_ig_learning_data_dir
  input_ig_learning_data_dir=$(readlink -f $input_ig_learning_data_dir)
  if [ ! -d $input_ig_learning_data_dir ]; then
    echo "Directory not found: $input_ig_learning_data_dir"
    input_ig_learning_data_dir=""
  fi
done

# Decide on a IG_LEARNING_DATA_DIR.
# Edit src/ig_learning_experiments/envrc, one time only.
echo "IG_LEARNING_DATA_DIR='$input_ig_learning_data_dir'" > $SCRIPT_PATH/src/ig_learning_experiments/envrc

################################################################################
# Sets and remembers IKEA_MODELS_DATASET_DIR.
input_ikea_models_dataset_dir=""

while [ -z "$input_ikea_models_dataset_dir" ]; do
  echo "Please input your desired IKEA_MODELS_DATASET_DIR, followed by [ENTER]:"
  read input_ikea_models_dataset_dir
  input_ikea_models_dataset_dir=$(readlink -f $input_ikea_models_dataset_dir)
  if [ ! -d $input_ikea_models_dataset_dir ]; then
    echo "Directory not found: $input_ikea_models_dataset_dir"
    input_ikea_models_dataset_dir=""
  fi
  if [ ! -e $input_ikea_models_dataset_dir/IKEA_desk_VIKA/obj_list.txt ]; then
    echo "Wrong directory, IKEA_desk_VIKA/obj_list.txt not in $input_ikea_models_dataset_dir"
    input_ikea_models_dataset_dir=""
  fi
done

# Decide on a ikea_models_dataset_dir.
# Edit src/ig_learning_experiments/envrc, one time only.
echo "IKEA_MODELS_DATASET_DIR='$input_ikea_models_dataset_dir'" > $SCRIPT_PATH/src/gazebo-room-with-furniture/envrc

################################################################################
# Builds IKEA meshes.
cd $SCRIPT_PATH/src/gazebo-room-with-furniture

source setup.bash
rm -rf models/ikea_models/meshes
echo "Will now build IKEA meshes, please wait..."
cd models && python3 ikea_models/create_models.py
