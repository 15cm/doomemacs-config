;;; my-tools/exec-path-from-shell/config.el -*- lexical-binding: t; -*-

(use-package! exec-path-from-shell
  :config
  (setq exec-path-from-shell-arguments "" )
  (setq exec-path-from-shell-variables '("PATH" "SSH_AGENT_PID" "SSH_AUTH_SOCK"))
  (exec-path-from-shell-initialize))
