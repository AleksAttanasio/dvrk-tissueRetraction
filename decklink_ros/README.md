
# DeckLink ROS

The DeckLink ROS module implements a set of ROS Nodes to expose BlackMagic Design DeckLink video playback & capture cards to a ROS network. It leverages [libdecklink](https://gitlab.com/Polimi-dVRK/decklink/libdecklink), a higher-level level interface to the BlackMagic Design SDK, to control the underlying card(s).

This module implements two ROS nodes:

- `publisher` reads images from a DeckLink device and pushes them to the ROS network. It uses an  `image_transport::CameraPublisher` to provide the intrinsic camera parameters with each image.
- `subscriber` reads images from a ROS topic and writes them to the specified DeckLink output. It can also be configured to support basic keying.

For more information on the DeckLink API and some useful tools please se the `libdecklink` README file.

## Installation Instructions

If you have a recent-ish installation of ROS you should be good to go. This project is known to work with both ROS Kinetic and ROS Lunar.

Simply clone the repository into your ROS workspace and build. The `libdecklink` component is already included as a submodule.

    git clone --recursive https://gitlab.com/Polimi-dVRK/decklink/decklink_ros.git

Finally, build the nodes with `catkin build`.

## The `publisher` node

The publisher node reads images from one input of the DeckLink card and publishes them to ROS topic. The simplest way to run the node is:

    rosrun decklink_ros publisher _decklink_device:="DeckLink Duo (1)"

This will create a `publisher` node, listening for images on the `DeckLink Duo (1)` and publishing the on `/image_raw`. To see all the connected decklink devices use the `deckstatus` tool included in the `libdecklink` distribution:

    $(find . -name deckview) --list

There are two ways of changing the topic that the images are published to. You can move it a different namespace by preprending the command with `ROS_NAMESPACE="/my/namespace"` like this:

    ROS_NAMESPACE="/my/namespace/" rosrun decklink_ros publisher _decklink_device:="DeckLink Duo (1)"

This will publish the images to `/my/namespace/image_raw`. Alternatively, if you need to rename the topic itself you can remap it to something else. e.g.

    rosrun decklink_ros publisher _decklink_device:="DeckLink Duo (1)" image_raw:=my_own_image_topic

This is not recommended however. The `image_raw` name is standard in ROS to indicate un-rectified images and integrates seamlessly with the `image_proc` set of nodes used for image filtering and rectification.

The node will additionally publish `sensor_msgs::CameraInfo` messages synchronised to each image message. If the camera is uncalibrated these will be empty. If a camera calibration file is available you can pass the path to the file in the `camera_info_url` parameter. This will allow the `image_proc` family of nodes to automatically generate rectified images.

The node accepts the following parameters:

| Parameter | Description |
| --------- | ----------- |
| `decklink_device` | The name of the capture (input) interface on the DeckLink card from which to read images. |
| `camera_name` | A name to identify the camera. The name is used to check that the right camera calibration information is being used. If the camera name in the calibration file and the name passed here differ a warning will be shown in the ROS console. If the name is not set the DeckLink device name is used instead. |
| `camera_frame` | The `tf` frame that the camera should attached to. This helps to keep point clouds generated with `stereo_image_proc` in the correct reference frame. The default value is the camera name. |
| `camera_info_url` | The location in which to locate the camera info file. This should a be an absolute file path. |

A launch file for a stereo endoscope is provided for documentation purposes in the `launch/` folder.

## The `subscriber` node

The subscriber node monitors a ROS image topic and writes any images it receives on the specified DeckLink device. The node expects `BGRA8` formatted images for simplicity and will produce an error if an image with a different formatting is used. The alpha channel is required to support keying.

The node accepts the following parameters:

| Parameter | Description |
| --------- | ----------- |
| `decklink_device` | The name of the playback (output) interface on the DeckLink card onto which the images will be written. |
| `topic` | The ROS topic from which the images will be read. |
| `image_format` | The name of the display mode to use. |
| `keying (bool)` | Whether or not to enable keying on the card. |
| `opacity (int)` | The opacity of the keyed images in the range 0 (transparent) to 255 (opaque). |

### Using keying

Keying on DeckLink devices is extremely fast (1ms extra latency on average). However to use keying you must provide an input onto which the images will be keyed. I/Os on DeckLink cards are grouped into pairs where one connector (left) is for input and the other (right) is for output. On modern cards it is possible to re-map each individual connector so that they can be used individually for input or for output but for keying we must retain the pair. You must connect your input and output cables to the connectors. The output will be the input video with the keyed image overlaid on top with the specified opacity.


The pixel format is hard coded to YUV422.
