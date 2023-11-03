(defvar my-misc-map (make-sparse-keymap) "My misc key map")

(defun my-kill-special-windows ()
  "Kill all windows displaying a buffer in `compilation-minor-mode'."
  (interactive)
  (dolist (win (window-list))
    (when (string-prefix-p "*" (buffer-name (window-buffer win)))
      (delete-window win))))

(define-key! my-misc-map
  "l" #'revert-buffer-quick
  "s" #'save-some-buffers
  "q" #'my-kill-special-windows)

(map! "C-s" #'save-buffer
      :i "M-." #'hippie-expand
      :nmiev [tab] #'indent-for-tab-command
      (:after evil
              (:map evil-surround-mode-map
               :v "s" #'evil-substitute
               :v "S" #'evil-surround-region))

      (:after evil-integration
       :nvm "t" 'evil-avy-goto-char-in-line
       :nvm "T" 'evil-avy-goto-symbol-1)

      (:after comint
       :i "C-k" 'kill-line)

      :leader
      :desc "misc" doom-leader-key my-misc-map
      :desc "Find file in project" "." #'projectile-find-file
      )

(use-package! rainbow-mode
  :defer t)

(use-package! vlf :defer t)

(use-package! beacon
  :config
  (beacon-mode 1))

(require 'evil-mc)
(global-evil-mc-mode 1)
(map! :map evil-mc-key-map
      :nvm "C-n" 'evil-mc-make-and-goto-next-match
      :nvm "C-p" 'evil-mc-make-and-goto-prev-match)

(which-key-add-key-based-replacements (concat "<SPC>" " TAB") "Eval expression")
(map!
 :leader
 [tab] #'eval-expression
 :desc "Layout & workspace" "l" doom-leader-workspace-map)

(map! :map doom-leader-workspace-map
      "l" #'+workspace/switch-to
      "L" #'+workspace/load)

(map! :leader "v" #'er/expand-region)
