docker build -t ros_melodic_ig_learning_reconstruction .
docker container rm ros_melodic_ig_learning_reconstruction;
rocker --home --user --nvidia --x11 --oyr-run-arg "--workdir=/home/vdhiman/wrk/ig_learning_experiments_ws -e TERM -v /tmp/emacs$UID/:/tmp/emacs$UID/ --name ros_melodic_ig_learning_reconstruction --net host" ros_melodic_ig_learning_reconstruction
#docker run -it -v $HOME:$HOME --entrypoint=bash --workdir=/home/vdhiman/wrk/ig_learning_experiments_ws -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY -e TERM --gpus all,capabilities=graphics --runtime nvidia -v /tmp/emacs$UID/:/tmp/emacs$UID/ --name ros_melodic_ig_learning_reconstruction rocker_ros_melodic_ig_learning_reconstruction_home_nvidia_oyr_run_arg_x11_user
