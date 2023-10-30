;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq doom-font (font-spec :family "Iosevka Nerd Font Mono" :size 14 :weight 'normal)
      doom-emoji-font (font-spec :family "Noto Color Emoji"))

(defun my-set-font ()
  (set-fontset-font t 'han (font-spec :family "Sarasa Mono SC" :size 14 :weight 'normal))
  (set-fontset-font t 'han (font-spec :family "Sarasa Mono J" :size 14 :weight 'normal) 'append)
  (set-fontset-font t 'kana (font-spec :family "Sarasa Mono J" :size 14 :weight 'normal)))

(add-hook 'after-setting-font-hook #'my-set-font)

(setq doom-theme 'doom-nord)

(setq display-line-numbers-type t)

(setq org-directory "~/org/")
(setq org-roam-directory org-directory)

