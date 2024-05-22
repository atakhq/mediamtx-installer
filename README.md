# mediamtx-installer

Install script to make mediamtx auto run on boot/restart and general setup info.

Copy script to target, make it executable:

`sudo chmod +x mediaMtxInstaller.sh`

Then run it:

`sudo bash mediaMtxInstaller.sh`

### Script will automatically detect cpu/os and download latest release build of mediamtx, and configure systemd service so it auto-starts on reboots.

## Modify mediamtx.yml as necessary:

### Subscribe server to an existing stream (ex: ip camera)

Edit `/usr/local/etc/mediamtx.yml` at the end of the file:

```
paths:
  # example:
  # my_camera:
  #   source: rtsp://my_camera
  amcrest:
    source: rtsp://admin:password@192.168.10.113
```

This example will make a stream available at `rtsp://<your-media-mtx-server-ip>:8554/amcrest` which you can test by using VLC player and trying to open a "network stream" with this URL.
