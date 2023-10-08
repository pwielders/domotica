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

echo "Booting the kernel configuration, using ${rootfstype} rootfs on ${rootdev}"
bootz ${kernel_addr_r} - ${fdt_addr_r}

# Recompile with:
# mkimage -C none -A arm -T script -d /boot/boot.cmd /boot/boot.scr
