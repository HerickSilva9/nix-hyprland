{ config, pkgs, ...}:

{

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  services.gnome.gnome-keyring.enable = true;
  services.pipewire.enable = true;

  # Habilita o udisks2 para gerenciamento de dispositivos
  services.udisks2.enable = true;

}