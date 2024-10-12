# Domotica :earth_americas:

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/apache-2-0)

Domotica is providing infrastructure to build firmware images based on Buildroot. Buildroot is known to keep the process of creating embedded Linux systems simple. The key benefit of domotica is that it is designed to be modular and extensible by using an external layer. This keeps the custom changes needed for the image away from the buildroot sources, making updating and maintaining images easy and clear. With a decent modern laptop it should take you about one hour, from cloning this repo, till a completed image.

## Getting Started :rocket:
To get started with Lithosphere, follow these steps:

1. Clone the domotica repository:
    ``` shell
    git clone https://github.com/pwielders/domotica.git
    ```

1. Initialize the submodules:
    ``` shell
    git submodule update --init --recursive
    ```

1. On-time Buildroot setup:
    ``` shell
    make -C buildroot BR2_EXTERNAL="${PWD}/addon" \
        O=${PWD}/raspberrypi0_bridge \
        raspberrypi0_bridge_defconfig
    ```

1. Build the image:
    ``` shell
    cd raspberrypi0_bridge
    make
    ```
    or
    ``` shell
    make -C raspberrypi0_bridge
    ```

## Updating the layers :arrows_clockwise:

To update the Domotica project, follow these steps:

1. Pull the latest changes from the Domotica repository:
    ``` shell
    git pull
    ```

2. Update the all the submodules:
    ``` shell
    git submodule update --init --recursive
    ```

   > Note that to be on the safe side, you should run git submodule update with the --init flag in case the Domotica commits you just pulled added new submodules, and with the --recursive flag if any submodules have nested submodules.


## Issues and Contributions :hammer_and_wrench:

If you encounter issues or have suggestions for improvements, please open an issue on the [ Domotica GitHub issue tracker](https://github.com/pwielders/domotica/issues). Contributions, such as bug fixes or new features, are always welcome. Please review our contribution guidelines before submitting a pull request.

## License :scroll:

Domotica is provided under the [Apache License 2.0](LICENSE). Please review the LICENSE file for more details. Note that this license only covers the files provided by buildroot-submodule. It does not cover buildroot (which is GPLv2 or later) nor any software installed by buildroot (they have their own licenses) nor your own code (which you are free to license as you want).

