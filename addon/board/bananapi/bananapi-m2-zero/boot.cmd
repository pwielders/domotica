setenv load_addr "0x45000000"
setenv overlay_error "false"

# default values
setenv verbosity "1"
setenv console "both"
setenv disp_mem_reserves "off"
setenv disp_mode "1920x1080p60"
setenv rootfstype "ext4"
setenv docker_optimizations "on"
setenv bootlogo "off"
setenv devnum "0"
setenv earlycon "off"
setenv prefix "/"
setenv partition "2"
setenv rootdev "/dev/mmcblk${devnum}p${partition}"

# Print boot source
itest.b *0x28 == 0x00 && echo "U-boot loaded from SD"
itest.b *0x28 == 0x02 && echo "U-boot loaded from eMMC or secondary SD"
itest.b *0x28 == 0x03 && echo "U-boot loaded from SPI"

echo "Boot script loaded from ${devtype}"

if test -e ${devtype} ${devnum} ${prefix}uboot.txt; then
	load ${devtype} ${devnum} ${load_addr} ${prefix}uboot.txt
	env import -t ${load_addr} ${filesize}
fi

# get PARTUUID of first partition on SD/eMMC it was loaded from
# mmc 0 is always mapped to device u-boot (2016.09+) was loaded from
if test "${devtype}" = "mmc"; then
	part uuid mmc ${devnum}:${partition} partuuid;
fi

if test "${console}" = "display" || test "${console}" = "both"; then setenv consoleargs "console=ttyS0,115200 console=tty1"; fi
if test "${console}" = "serial"; then setenv consoleargs "console=ttyS0,115200"; fi
if test "${earlycon}" = "on"; then setenv consoleargs "earlycon ${consoleargs}"; fi
if test "${bootlogo}" = "on"; then setenv consoleargs "bootsplash.bootfile=bootsplash.jpg ${consoleargs}"; fi

setenv bootargs "root=${rootdev} rootwait rootfstype=${rootfstype} ${consoleargs} hdmi.audio=EDID:0 consoleblank=0 disp.screen0_output_mode=${disp_mode} loglevel=${verbosity} ubootpart=${partuuid} ubootsource=${devtype} usb-storage.quirks=${usbstoragequirks} ${extraargs} ${extraboardargs}"

if test "${disp_mem_reserves}" = "off"; then setenv bootargs "${bootargs} sunxi_ve_mem_reserve=0 sunxi_g2d_mem_reserve=0 sunxi_fb_mem_reserve=16"; fi
if test "${docker_optimizations}" = "on"; then setenv bootargs "${bootargs} cgroup_enable=memory swapaccount=1"; fi

fatload ${devtype} ${devnum} ${kernel_addr_r} ${prefix}zImage
fatload ${devtype} ${devnum} ${fdt_addr_r} ${prefix}sun8i-h2-plus-bananapi-m2-zero.dtb

fdt addr ${fdt_addr_r}
fdt resize
setexpr fdt_addr_overlay_r ${fdt_addr_r} + F000

for overlay in ${overlays}; do
    echo "Adding overlay: ${overlay}"
    fatload ${devtype} ${devnum} ${fdt_addr_overlay_r} ${prefix}overlays/${overlay}.dtb && fdt apply ${fdt_addr_overlay_r}
done

# overlays fixup script
# implements (or rather substitutes) overlay arguments functionality
# using u-boot scripting, environment variables and "fdt" command

# setexpr test_var ${tmp_bank} - A
# works only for hex numbers (A-F)

setenv decompose_pin 'setexpr tmp_bank sub "P(A|C|D|G)\\d+" "\\1";
setexpr tmp_pin sub "P\\S(\\d+)" "\\1";
test "${tmp_bank}" = "A" && setenv tmp_bank 0;
test "${tmp_bank}" = "C" && setenv tmp_bank 2;
test "${tmp_bank}" = "D" && setenv tmp_bank 3;
test "${tmp_bank}" = "G" && setenv tmp_bank 6'

if test -n "${param_spinor_spi_bus}"; then
        test "${param_spinor_spi_bus}" = "0" && setenv tmp_spi_path "spi@01c68000"
        test "${param_spinor_spi_bus}" = "1" && setenv tmp_spi_path "spi@01c69000"
        fdt set /soc/${tmp_spi_path} status "okay"
        fdt set /soc/${tmp_spi_path}/spiflash status "okay"
        if test -n "${param_spinor_max_freq}"; then
                fdt set /soc/${tmp_spi_path}/spiflash spi-max-frequency "<${param_spinor_max_freq}>"
        fi
        if test "${param_spinor_spi_cs}" = "1"; then
                fdt set /soc/${tmp_spi_path}/spiflash reg "<1>"
        fi
        env delete tmp_spi_path
fi

if test -n "${param_spidev_spi_bus}"; then
        test "${param_spidev_spi_bus}" = "0" && setenv tmp_spi_path "spi@01c68000"
        test "${param_spidev_spi_bus}" = "1" && setenv tmp_spi_path "spi@01c69000"
        fdt set /soc/${tmp_spi_path} status "okay"
        fdt set /soc/${tmp_spi_path}/spidev status "okay"
        if test -n "${param_spidev_max_freq}"; then
                fdt set /soc/${tmp_spi_path}/spidev spi-max-frequency "<${param_spidev_max_freq}>"
        fi
        if test "${param_spidev_spi_cs}" = "1"; then
                fdt set /soc/${tmp_spi_path}/spidev reg "<1>"
        fi
        env delete tmp_spi_path
fi

if test -n "${param_pps_pin}"; then
        setenv tmp_bank "${param_pps_pin}"
        setenv tmp_pin "${param_pps_pin}"
        run decompose_pin
        fdt set /soc/pinctrl@01c20800/pps_pins pins "${param_pps_pin}"
        fdt get value tmp_phandle /soc/pinctrl@01c20800 phandle
        fdt set /pps@0 gpios "<${tmp_phandle} ${tmp_bank} ${tmp_pin} 0>"
        env delete tmp_pin tmp_bank tmp_phandle
fi

if test "${param_pps_falling_edge}" = "1"; then
        fdt set /pps@0 assert-falling-edge
fi

for f in ${overlays}; do
        if test "${f}" = "pwm"; then
                setenv bootargs_new ""
                for arg in ${bootargs}; do
                        if test "${arg}" = "console=ttyS0,115200"; then
                                echo "Warning: Disabling ttyS0 console due to enabled PWM overlay"
                        else
                                setenv bootargs_new "${bootargs_new} ${arg}"
                        fi
                done
                setenv bootargs "${bootargs_new}"
        fi
done

if test -n "${param_w1_pin}"; then
        setenv tmp_bank "${param_w1_pin}"
        setenv tmp_pin "${param_w1_pin}"
        run decompose_pin
        fdt set /soc/pinctrl@01c20800/w1_pins pins "${param_w1_pin}"
        fdt get value tmp_phandle /soc/pinctrl@01c20800 phandle
        fdt set /onewire@0 gpios "<${tmp_phandle} ${tmp_bank} ${tmp_pin} 0>"
        env delete tmp_pin tmp_bank tmp_phandle
fi

if test "${param_w1_pin_int_pullup}" = "1"; then
        fdt set /soc/pinctrl@01c20800/w1_pins bias-pull-up
fi

if test "${param_uart1_rtscts}" = "1"; then
        fdt get value tmp_phandle1 /soc/pinctrl@01c20800/uart1 phandle
        fdt get value tmp_phandle2 /soc/pinctrl@01c20800/uart1_rts_cts phandle
        fdt set /soc/serial@01c28400 pinctrl-names "default" "default"
        fdt set /soc/serial@01c28400 pinctrl-0 "<${tmp_phandle1}>"
        fdt set /soc/serial@01c28400 pinctrl-1 "<${tmp_phandle2}>"
        env delete tmp_phandle1 tmp_phandle2
fi

if test "${param_uart2_rtscts}" = "1"; then
        fdt get value tmp_phandle1 /soc/pinctrl@01c20800/uart2 phandle
        fdt get value tmp_phandle2 /soc/pinctrl@01c20800/uart2_rts_cts phandle
        fdt set /soc/serial@01c28800 pinctrl-names "default" "default"
        fdt set /soc/serial@01c28800 pinctrl-0 "<${tmp_phandle1}>"
        fdt set /soc/serial@01c28800 pinctrl-1 "<${tmp_phandle2}>"
        env delete tmp_phandle1 tmp_phandle2
fi

if test "${param_uart3_rtscts}" = "1"; then
        fdt get value tmp_phandle1 /soc/pinctrl@01c20800/uart3 phandle
        fdt get value tmp_phandle2 /soc/pinctrl@01c20800/uart3_rts_cts phandle
        fdt set /soc/serial@01c28c00 pinctrl-names "default" "default"
        fdt set /soc/serial@01c28c00 pinctrl-0 "<${tmp_phandle1}>"
        fdt set /soc/serial@01c28c00 pinctrl-1 "<${tmp_phandle2}>"
        env delete tmp_phandle1 tmp_phandle2
fi


echo "Booting the kernel configuration, using ${rootfstype} rootfs on ${rootdev}"
bootz ${kernel_addr_r} - ${fdt_addr_r}

# Recompile with:
# mkimage -C none -A arm -T script -d /boot/boot.cmd /boot/boot.scr
