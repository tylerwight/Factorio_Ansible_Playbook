mkdir -p /opt/factorio/saves
rm -r /opt/factorio/saves/*zip
/opt/factorio/bin/x64/factorio --create /opt/factorio/saves/map1.zip --map-gen-settings /opt/factorio/data/map-gen-settings.json
