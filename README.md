# Running example_aggrevate.launch

1. Clone the repository

```shellsession
$ git clone --recursive git@github.com:wecacuee/ig_learning_experiments_ws.git
```

2. Build the docker image

```shellsession
$ docker build -t ros_melodic_ig_learning_reconstruction .
```

3. Run the docker image

``` shellsession
./docker-run.sh
```

4. Inside the docker image

4.1 Add yourself as the user and change shell to the user

``` shellsession
stat -c "useradd -u %u dockeruser" $(pwd) | sh -
su --preserve-environment -lc bash dockeruser
```

4.2 Decide on a IG_LEARNING_DATA_DIR. Edit `src/ig_learning_experiments/envrc`
One time only.

``` shellsession
echo "IG_LEARNING_DATA_DIR='/home/vdhiman/dat/gazebo-room-with-furniture/worlds/'" > src/ig_learning_experiments/envrc
source src/ig_learning_experiments/setup.bash
```

4.3 Catkin build

``` shellsession
$ catkin build
```

4.4. Download and generate ikea models.  [Follow instructions here.](./src/gazebo-room-with-furniture/models/ikea_models/README.md)

``` shellsession
source ./src/gazebo-room-with-furniture/setup.bash
```

4.5. Generate random worlds

``` shellsession
cd ./src/gazebo-room-with-furniture/worlds/
pip install -r requirements.txt
python random_world.py --dest_file_fmt $IG_LEARNING_DATA_DIR/worlds/world%d.sdf
```

4.4 Source environment

``` shellsession
cd <root>
source setup.bash
```

4.5 Generate point clouds from `worlds%d.sdf`.

[Follow Instructions here.](./src/ig_learning_experiments/py/create_view_space.py)

4.6. Roslaunch example_aggrevate.launch

This will do the training
``` shellsession
roslaunch ig_learning_experiments example_aggrevate.launch
```

For testing

``` shellsession
roslaunch ig_learning_experiments example_test_online_policy.launch
```



