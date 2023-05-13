## Standalone

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

1. Create Partitions
   We will create three partitions as follows :-

```
[ ............... ############################################################### --------------- ]
  boot (fat32)    root (ext4)                                                     swap
  (512MB)         (remaining)                                                     (~RAM size)
```

Use lsblk to get where the disk is located.

I am assuming disk at /dev/sda and RAM size of 32GB. Make appropriate changes to following commands wherever necessary.  
> Size of swap must be atleast size of RAM to support hibernation as entire disk content is flushed to memory. Common recommendation is twice the size of RAM. However for a 32GB memory, I feel like 64GB swap is overkill and a waste of disk space. With this large memory it is unlikely that you will run out of memory and use swap space. For this reason, we will be going with only 32GB swap partition

```sh
parted /dev/sda -- mklabel gpt
parted /dev/sda -- mkpart primary 512MB -32GB
parted /dev/sda -- mkpart primary linux-swap -32GB 100%
parted /dev/sda -- mkpart ESP fat32 1MB 512MB
parted /dev/sda -- set 3 esp on
```

You can safely ignore following warning :- Information: You may need to update /etc/fstab.
Run lsblk again to verify parititions are created properly.

2. Format partitions

```sh
mkfs.ext4 -L NIXROOT /dev/sda1
mkswap -L NIXSWAP /dev/sda2
mkfs.fat -F 32 -n NIXBOOT /dev/sda3
```

3. Mount Partitions

```sh
mount /dev/disk/by-label/NIXROOT /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/NIXBOOT /mnt/boot
swapon /dev/sda2
```

### Install NixOS

1. Install git

```sh
nix-env -iA nixos.git
```

2. Clone repo

```sh
git clone yogeshkumar98103/.dotfiles
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
git commit -m "added hardware.nix for $(hostname)"
git push origin main
```
