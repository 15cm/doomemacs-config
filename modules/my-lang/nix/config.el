(use-package! nix-mode
  :mode "\\.nix\\'"
  :init
  ;; Treat flake.lock files as json. Fall back to js-mode because it's faster
  ;; than js2-mode, and its extra features aren't needed there.
  (add-to-list 'auto-mode-alist
               (cons "/flake\\.lock\\'"
                     (if (modulep! :lang json)
                         'json-mode
                       'js-mode)))
  :config
  (if (modulep! +lsp)
      (add-hook 'nix-mode-hook #'lsp! 'append)
    (set-company-backend! 'nix-mode 'company-dabbrev-code))
  (map! :localleader
        :map nix-mode-map
        "=" #'nix-format-buffer
        "'" #'nix-repl-show)
  )

(use-package! nix-repl
  :commands nix-repl-show)
