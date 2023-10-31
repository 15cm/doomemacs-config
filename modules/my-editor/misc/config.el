(defvar my-misc-map (make-sparse-keymap) "My misc key map")

(define-key! my-misc-map
             "l" #'revert-buffer-quick)

(map! "C-s" #'save-buffer
      :i "M-." #'hippie-expand
      :nmiev :desc "Indent" [tab] #'indent-for-tab-command
      (:after evil
              (:map evil-surround-mode-map
                    :v "s" #'evil-substitute
                    :v "S" #'evil-surround-region))

      (:after evil-integration
              :nv "t" 'evil-avy-goto-char-in-line
              :nv "T" 'evil-avy-goto-symbol-1)


      (:after comint
              :i "C-k" 'kill-line)

      :leader
      :desc "misc" "m" my-misc-map
      )

(use-package! rainbow-mode
              :defer t)

(use-package! vlf :defer t)

(use-package! beacon
              :config
              (beacon-mode 1))

(map!
 :leader
 :desc "Eval expression" [tab] #'eval-expression
 :desc "Layout & workspace" "l" doom-leader-workspace-map)

(map! :map doom-leader-workspace-map
      "l" #'+workspace/switch-to
      "L" #'+workspace/load)
