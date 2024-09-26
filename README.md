# Lithosphere :earth_americas:

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/apache-2-0)

Lithosphere is providing infrastructure to build thunder firmware images based on Buildroot. Buildroot is known to keep the process of creating embedded Linux systems simple. The key benefit of Lithosphere is that it is designed to be modular and extensible by using external layers. This keeps the custom changes needed for thunder away from the buildroot sources, making updating and maintaining images easy and clear. With a decent modern laptop it should take you about one hour, from cloning this repo, till a completed image with Thunder.

## Getting Started :rocket:
To get started with Lithosphere, follow these steps:

1. Clone the Lithosphere repository:
    ``` shell
    git clone https://github.com/pwielders/domotica.git
    ```

1. Initialize the submodules:
    ``` shell
    git submodule update --init --recursive
    ```

1. On-time Buildroot setup:
    ``` shell
    make \
        -C buildroot \
        BR2_EXTERNAL="${PWD}/addon" \
        O=${PWD}/raspberrypi3_wpe \
        raspberrypi3_wpe_defconfig
    ```

1. Build the image:
    ``` shell
    cd raspberrypi3_wpe
    make
    ```
    or
    ``` shell
    make -C raspberrypi3_wpe
    ```

## Updating the layers :arrows_clockwise:

To update the Lithosphere project, follow these steps:

1. Pull the latest changes from the Lithosphere repository:
    ``` shell
    git pull
    ```

2. Update the all the submodules:
    ``` shell
    git submodule update --init --recursive
    ```

   > Note that to be on the safe side, you should run git submodule update with the --init flag in case the Lithosphere commits you just pulled added new submodules, and with the --recursive flag if any submodules have nested submodules.


## Issues and Contributions :hammer_and_wrench:

If you encounter issues or have suggestions for improvements, please open an issue on the [ Thunder GitHub issue tracker](https://github.com/rdkcentral/thunder/issues). Contributions, such as bug fixes or new features, are always welcome. Please review our contribution guidelines before submitting a pull request.

## License :scroll:

Lithosphere is provided under the [Apache License 2.0](LICENSE). Please review the LICENSE file for more details. Note that this license only covers the files provided by buildroot-submodule. It does not cover buildroot (which is GPLv2 or later) nor any software installed by buildroot (they have their own licenses) nor your own code (which you are free to license as you want).

