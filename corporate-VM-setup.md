# How to setup VM to work with VPN and SSL proxy

## Virtualbox network setup
To enable networking behind a VPN set the network card to NAT mode and choose paravirtualized network (virtio-net).

For Windows guest you then need correct driver. Win does not have the virtio-net drivers available.
The drivers are available here: https://github.com/virtio-win/virtio-win-pkg-scripts/blob/master/README.md

1. Download Stable ISO. 
1. Mount ISO into VM
1. Open Device Manager (This PC -> right click -> Manage)
1. Open the unknown device (virtio network adapter)
1. Update driver and select choose file manually
1. Navigate to [ISO]\NetKVM\w10 (or appropriate windows version)
1. Install the driver

If during the installation Win complains about unsigned drivers, just select Yes and force the install.

After this setup, the VM should be able to access both the internet, and the resources behind VPN setup on the host.

If you need to connect to the inside of the VM, just add host only network.

## How to enable MitM because of corporate bull*
### Setting up IDEA and Gradle 
First get the root CA for the SSL proxy that is installed in your PC/network.

In IDEA go to Settings -> Tools -> Server Certificates and add the root CA here. 
This way all connections IDEA makes will use the supplied CA and IDEA stops complaining about broken SSL.

To fix the SSL for Gradle the setup is more convoluted. It is necessary to provide Gradle JVM with the correct keystore containg the root CA.
Easiest way to set this up is to create custom keystore for Gradle containing the root CA.

First create the keystore:
```
keytool -importcert -alias <SSL-Shit-alias> -file <certificate.cer> -keystore cacerts
```

Next set the gradle to use the new keystore:
```
systemProp.javax.net.ssl.trustStore=<path-to-keystore>
systemProp.javax.net.ssl.trustStorePassword=<keystore-password>
```

Restart the IDE and Gradle daemon (if applicable) and test the new setup.
