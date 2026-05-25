{ self, inputs, ... }: {
  flake.nixosModules.sypseHardware = { config, lib, pkgs, modulesPath, ... }: {
   imports = [ (modulesPath + "/installer/scan/not-detected.nix")
   ];

   boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
   boot.initrd.kernelModules = [ ];
   boot.kernelModules = [ "kvm-intel" ];
   boot.extraModulePackages = [ ];
   boot.loader.systemd-boot.enable = true;
   boot.loader.efi.canTouchEfiVariables = true;

   fileSystems."/" =
     { device = "/dev/disk/by-uuid/8a45442e-318c-4444-a2af-14e550018bd7";
       fsType = "ext4";
     };

   fileSystems."/boot" =
     { device = "/dev/disk/by-uuid/AC19-38D8";
       fsType = "vfat";
       options = [ "fmask=0077" "dmask=0077" ];
     };

   swapDevices =
     [ { device = "/dev/disk/by-uuid/5fd9e32e-659b-4d4a-b1c1-a716837bb998"; }
     ];

   nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
   hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
 };
}
