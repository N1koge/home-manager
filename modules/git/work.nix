{ ... }:

{
  programs.git = {
    enable = true;
      userName = "";
      userEmail = "";
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
