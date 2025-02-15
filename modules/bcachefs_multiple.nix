# configuration.nix
{ pkgs, ... }: {
  systemd.services.foo-bar = {
    description = "/foo/bar";
    bindsTo = ["dev-sda.device" "dev-sdb.device"];
    after = ["dev-sda.device" "dev-sdb.device" "local-fs-pre.target"];
    before = ["umount.target" "local-fs.target"];
    conflicts = ["umount.target"];
    unitConfig = {
      RequiresMountsFor = "/foo";
      DefaultDependencies = false;
    };

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.util-linux}/bin/mount -t bcachefs /dev/sda:/dev/sdb /foo/bar";
      ExecStop = "${pkgs.util-linux}/umount /foo/bar";
    };
  };
}

/*
Oh, my bad; to have it run at boot you also need wantedBy = ["local-fs.target"];

https://discourse.nixos.org/t/how-do-i-mount-multiple-bcachefs-devices-on-boot/37463
*/

