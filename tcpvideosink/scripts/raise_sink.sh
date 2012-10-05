#!/bin/bash

# gst-launch -v tcpserversrc host=192.168.1.2 port=5000 ! gdpdepay ! tee name=tee1 ! ffdec_h264 ! identity ! 'video/x-raw-rgb,width=640,height=480,format=I420' ! mix.sink_0 videomixer2 name=mix sink_1::xpos=0 sink_1::ypos=0 sink_1::alpha=0.5 sink_1::zorder=3 sink_0::xpos=0 sink_0::ypos=0 sink_0::alpha=1 sink_0::zorder=2 ! ffmpegcolorspace ! 

gst-launch -v filesrc location=/home/kostas/Pictures/gow4_640x480.png ! decodebin2 ! imagefreeze ! ffmpegcolorspace ! 'video/x-raw-rgb,width=640,height=480,format=I420' ! videomixer name=mix ! ffmpegcolorspace ! timeoverlay halign=right ! clockoverlay halign=right valign=bottom shaded-background=true time-format="%H:%M:%S" ! v4l2sink device=/dev/video0 sync=false 

#gst-launch -v tcpserversrc host=192.168.1.2 port=5000 ! gdpdepay ! tee name=tee1 ! ffdec_h264 ! identity ! 'video/x-raw-rgb,width=640,height=480,format=I420' ! mix.sink_0 videomixer2 name=mix sink_1::xpos=0 sink_1::ypos=0 sink_1::alpha=0.5 sink_1::zorder=3 sink_0::xpos=0 sink_0::ypos=0 sink_0::alpha=1 sink_0::zorder=2 ! ffmpegcolorspace ! timeoverlay halign=right ! clockoverlay halign=right valign=bottom shaded-background=true time-format="%H:%M:%S" ! v4l2sink device=/dev/video0 sync=false tee1. ! queue ! mpegtsmux ! multifilesink location=/home/kostas/workspace/streaming_output/worker0-`date +"%F-%H.%M.%S"`-%06d.ts next-file=1 filesrc location=/home/kostas/Pictures/gow4_640x480.png ! decodebin2 ! imagefreeze ! ffmpegcolorspace ! 'video/x-raw-rgb,width=640,height=480,format=I420' ! mix.sink_1 