# Updated and Simplified Instructions

1. Use `cogrob_dockerlogin` to enter an enviroment for this experiment.
```
echo "DOCKERLOGIN_IMAGE=docker.cogrob.com/ros_melodic_ig_learning_experiments_env" > $HOME/.dockerloginrc_ig
cogrob_dockerlogin ig
```

2. Run the initial setup script.
```
./initial_setup.sh
```

Be prepare to offer IG_LEARNING_DATA_DIR and IKEA_MODELS_DATASET_DIR.

```
ls $IG_LEARNING_DATA_DIR
>> learnt_predictors parameters precomputed_expert test train worlds

ls $IKEA_MODELS_DATASET_DIR
>> all_obj.txt IKEA_bed_BEDDINGE IKEA_bed_BIRKELAND IKEA_bed_BRIMNES ...
```

3. Generate random worlds if not using a prebuild IG_LEARNING_DATA_DIR. Follow the instructions below.

4. Build the catkin workspace.

```
catkin build
```

5. Run example_aggrevate.
```
source setup.bash
# This will do the training
roslaunch ig_learning_experiments example_aggrevate.launch

# For testing
roslaunch ig_learning_experiments example_test_online_policy.launch
```

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
