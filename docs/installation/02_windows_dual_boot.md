## Windows Dual Boot

### Network

Wired network should be detected automatically
For wireless network use following:-

```sh
systemctl start wpa_supplicant.service
wpa_cli
```

For home networks

```
> add_network
0
> set_network 0 ssid "<Network Name>"
OK
> set_network 0 psk "<Password>"
OK
> set_network 0 key_mgmt WPA-PSK
OK
> enable_network 0
OK
> quit
```

For enterprise networks

```
> add_network
0
> set_network 0 ssid "<Network Name>"
OK
> set_network 0 identity "<username>"
OK
> set_network 0 password "<password>"
OK
> set_network 0 key_mgmt WPA-EAP
OK
> enable_network 0
OK
> quit
```

### Storage

1. Ensure that you have created a partition in windows formatted without any filesystem.

2. We already have a boot partition from windows installation. We need to create only root and swap partitions.

```
[ ############################################################### --------------- ]
  root (ext4)                                                     swap
  (remaining)                                                     (~RAM size)
```

We will use LVM (Logical Volume Manager to subpartition the partition we created in windows.  
Assuming empty partition is located at /dev/nvme0n1p1 and RAM size of 16GB. Here I am using swap size of 20GB. Feel free to change it as you like.

```sh
#Initialize a physical volume to be used by lvm
pvcreate /dev/nvme0n1p5

# create a volume group
vgcreate vgnixos /dev/nvme0n1p5

# Create a swap volume
lvcreate -C y -L 20G -n swap vgnixos

# Create root partition
lvcreate -l 100%FREE -n nixos vgnixos
```

lsblk should show our new volumes

3. Format partitions

```sh
mkfs.ext4 -L NIXROOT /dev/vgnixos/nixos
mkswap -L NIXSWAP /dev/vgnixos/swap
```

4. Mount Partitions. Assuming windows boot partition at /dev/nvme0n1p1  
   TODO: How to check which one is the windows boot partition

```sh
mount /dev/vgnixos/nixos /mnt
mkdir -p /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot
swapon /dev/vgnixos/swap
```

### Install NixOS

1. Install git

```sh
nix-env -iA nixos.git
```

2. Clone repo

```sh
git clone piconova/.dotfiles
```

3. Install nixos

```sh
cd .dotfiles
nixos-generate-config --root /mnt
cp /mnt/etc/nixos/hardware-cnfiguration.nix hosts/<host>/hardware.nix
nixos-install --flake .#<host>
cp -r . /mnt/home/yogesh/.dotfiles
reboot
```

### First Boot

On first boot we won't be able to log in to desktop because it is not installed yet. Xsession is managed by home-manager and we are yet to apply our home-manager configuration.

1. Apply home manager configuration
   Go to command line mode using <Ctrl> + <Alt> + F3.

```sh
mkdir -p .config/{Code/User}
cd .dotfiles
sudo chown yogesh -R .
nix run path:.#homeManagerConfigurations.$(hostname).activationPackage --verbose
sudo reboot
```

2. Setup our ssh and gpg keys

```sh
cd .dotfiles
export GH_TOKEN=<your-token>
gh auth status
just setup-ssh-keys
just setup-gpg-keys
```

Test new keys by making a commit and pushing it to github

```sh
git add .
git commit -m "added hardware-configuration for $(hostname)"
git push origin main
```
