{ ... }:

{
  programs.git = {
    enable = true;
      userName = "N1koge";
      userEmail = "rmrf.mc.npro.6672@gmail.com";
      extraConfig = {
        github.user = "N1koge";
        core = {
          sshCommand = "ssh -i ~/.ssh/github";
          autocrlf = "input";
        };
        init.defaultBranch = "main";
        pull = {
          rebase = false;
          ff = "only";
        };
      };
    };
}
