. devel/setup.zsh
. src/gazebo-room-with-furniture/setup.bash

# . src/ig_learning_experiments/setup.bash
while read LINE
  do eval "export $LINE"
done < src/ig_learning_experiments/envrc
