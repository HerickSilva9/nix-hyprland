{ config, pkgs, ...}:

{

    # Habilitar PipeWire e WirePlumber
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;

    wireplumber.enable = true;

  };

}