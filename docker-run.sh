docker build -t ros_kinetic_ig_learning_reconstruction .
docker container start -ia ros_kinetic_ig_learning_reconstruction || \
    docker run -it -e HOME -v /home/vdhiman:/home/vdhiman --entrypoint=bash --workdir=/home/vdhiman/wrk/ig_learning_experiments_ws -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY -e TERM --gpus all,capabilities=graphics --runtime nvidia -v /tmp/emacs$UID/:/tmp/emacs$UID/ --name ros_kinetic_ig_learning_reconstruction ros_kinetic_ig_learning_reconstruction
