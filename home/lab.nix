# Tooling to administrate the homelab cluster (github.com/nsc99/lab).
{ pkgs, config, ... }:
let
  kubeconfig = "${config.home.homeDirectory}/.kube/lab";
in
{
  home.packages = with pkgs; [
    kubectl
    kubectx
    fluxcd
    kubernetes-helm
    kustomize
    kubeconform
    # lab encrypts to the same age key as this repo (the `operator` key);
    # ssh-to-age derives host age keys for its .sops.yaml.
    age
    ssh-to-age
  ];

  programs.k9s.enable = true;

  # Admin kubeconfig for the k3s cluster, context `lab`.
  sops.secrets.kubeconfig-lab = {
    key = "kube/lab";
    path = kubeconfig;
  };
  home.sessionVariables.KUBECONFIG = kubeconfig;

  # Hosts are reached as <host>.lab by the operator user; the lab repo's
  # nix/scripts/rebuild.sh deploys over this.
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*.lab" = {
      user = "operator";
      identityFile = "~/.ssh/id_ed25519";
    };
  };
}
