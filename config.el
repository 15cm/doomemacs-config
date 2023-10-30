;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq doom-font (font-spec :family "Iosevka Nerd Font Mono" :size 16 :weight 'normal)
      doom-emoji-font (font-spec :family "Noto Color Emoji"))

 (defun my-set-font ()
   (set-fontset-font t 'han (font-spec :family "Sarasa Mono SC" :size 16 :weight 'normal))
   (set-fontset-font t 'han (font-spec :family "Sarasa Mono J" :size 16 :weight 'normal) nil 'append)
   (set-fontset-font t 'kana (font-spec :family "Sarasa Mono J" :size 16 :weight 'normal))
   )
 
 (add-hook 'after-setting-font-hook #'my-set-font)

(use-package! color-theme-sanityinc-tomorrow
              :config (setq doom-theme 'sanityinc-tomorrow-night))


(setq display-line-numbers-type 'relative)

(setq org-directory "~/org/")

