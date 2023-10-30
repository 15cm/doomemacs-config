(map! "C-s" #'save-buffer
      :after evil
      :map evil-surround-mode-map
      :v "s" #'evil-substitute
      :v "S" #'evil-Surround-region

      :after evil-integration
      :nv "t" 'evil-avy-goto-char-in-line
      :nv "T" 'evil-avy-goto-symbol-1

      :after comint
      :i "C-k" 'kill-line
      )
