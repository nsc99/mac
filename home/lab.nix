# Tooling to administrate the homelab cluster (github.com/nsc99/lab).
{ pkgs, config, ... }:
let
  kubeconfig = "${config.home.homeDirectory}/.kube/lab";
in
{
  home.packages = with pkgs; [
    kubectl
    kubectx
    kubecm
    fluxcd
    kubernetes-helm
    kustomize
    kubeconform
    # VM for the lab repo's local test cluster (local/cluster.sh).
    lima
    # lab encrypts to the same age key as this repo (the `operator` key);
    # ssh-to-age derives host age keys for its .sops.yaml.
    age
    ssh-to-age
  ];

  programs.k9s.enable = true;

  # Admin kubeconfig for the k3s cluster, context `lab`. Writable so kubens can
  # set a namespace on it; sops-nix restores it on every activation.
  sops.secrets.kubeconfig-lab = {
    key = "kube/lab";
    path = kubeconfig;
    mode = "0600";
  };

  # Hosts are reached as <host>.lab by the operator user; the lab repo's
  # nix/scripts/rebuild.sh deploys over this.
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*.lab" = {
      User = "operator";
      IdentityFile = "~/.ssh/id_ed25519";
    };
  };
}
