;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(defun my-init-load-path ()
  (add-load-path! "lisp"))

(my-init-load-path)

(setq my-font-size 16)

(setq doom-font (font-spec :family "Iosevka Nerd Font Mono" :size my-font-size :weight 'normal)
      doom-emoji-font (font-spec :family "Noto Color Emoji"))

(setq nerd-icons-font-names '("SymbolsNerdFontMono-Regular.ttf"))

(add-hook! 'after-setting-font-hook
  (set-fontset-font t 'han (font-spec :family "Sarasa Mono SC" :size my-font-size :weight 'normal))
  (set-fontset-font t 'han (font-spec :family "Sarasa Mono J" :size my-font-size :weight 'normal) nil 'append)
  (set-fontset-font t 'cjk-misc (font-spec :family "Sarasa Mono SC" :size my-font-size :weight 'normal))
  (set-fontset-font t 'cjk-misc (font-spec :family "Sarasa Mono J" :size my-font-size :weight 'normal) nil 'append)
  (set-fontset-font t 'kana (font-spec :family "Sarasa Mono J" :size my-font-size :weight 'normal)))

(use-package! solarized-theme)
(use-package! color-theme-sanityinc-tomorrow
  :config (setq doom-theme 'sanityinc-tomorrow-night))
(let ((theme-conf-file "~/.config/emacs-scripts/load-theme.el"))
  (when (file-exists-p theme-conf-file)
    (load-file theme-conf-file)))

(defun my-doom-reload ()
  (interactive)
  ;; New packages need reload-packages to update the load path.
  (doom/reload)
  (doom/reload-packages)
  (doom/reload)
  )

(map! :leader
      "C-r" #'my-doom-reload)

(setq display-line-numbers-type 'relative)

(setq org-directory "~/org/")

(after! persp-mode
  (setq persp-emacsclient-init-frame-behaviour-override "main"))
