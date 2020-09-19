mkdir -p /opt/factorio/bak
cd /opt/factorio/bak
mkdir $(date +"%Y-%m-%d_%H:%M")
cp /opt/factorio/saves/* /opt/factorio/bak/$(date +"%Y-%m-%d_%H:%M")/
