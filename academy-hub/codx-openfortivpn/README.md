## Connect multiple containers with openfortivpn and SSO
We use openfortivpn to create a container and use it as VPN gateway for all other containers

> About SSO
FortiVPN is not working fine so you need to login at Forti portal and copy the value for cookie SVPNCOOKIE

### Setup
Create .env file with:
``` 
  VPN_HOST=vpnfg.your-hot.com
  VPN_PORT=443
  VPN_USER=your.user
  VPN_PWD=You**Passwd
  SVPNCOOKIE=KGKGKGKGSXXXXX...
```

## Usage
Update docker-compose.yaml adding all services that need vpn.
Set `network_mode: conatiner:vpn`

```
docker-compose up -d
```

#### Reconnect
To reconnect VPN
Update .env file and run docker-compose up -d again.

