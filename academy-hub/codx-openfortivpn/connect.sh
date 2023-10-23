openfortivpn ${VPN_HOST}:${VPN_PORT} \
    -u ${VPN_USER} -p ${VPN_PWD} -v -v -v \
    --cookie="SVPNCOOKIE=${SVPNCOOKIE}" \
    --trusted-cert abc406498fd2765e5e0001114afd4924853d8a188a3319694d9e88a09836821d &