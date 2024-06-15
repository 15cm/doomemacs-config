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

  ;; Not working.
  ;; (when (modulep! +lsp-ai)
  ;;     (after! lsp-mode
  ;;       (lsp-register-client
  ;;        (make-lsp-client :new-connection (lsp-stdio-connection (lambda () "lsp-ai"))
  ;;                         :major-modes '(nix-mode)
  ;;                         :initialization-options (lambda () (append
  ;;                                                             `(:memory (:file_store (:crawl :json-false)))
  ;;                                                             `(:models (:model1 (:type "ollama" :model "deepseek-coder")))
  ;;                                                             `(:completion (:model "model1" :parameters (:max_context 2000 (:options (:num_predict 32)))))
  ;;                                                             ))
  ;;                         :initialized-fn (lambda (workspace)
  ;;                                           (with-lsp-workspace workspace
  ;;                                             (lsp--set-configuration
  ;;                                              (lsp-configuration-section "nil"))))
  ;;                         :synchronize-sections '("nil")
  ;;                         :server-id 'lsp-ai))
  ;;       )
  ;;     (add-hook 'nix-mode-hook #'lsp-deferred)
  ;;     (add-hook 'nix-mode-hook (lambda () (lsp-completion-mode 1)))
  ;;     )
  )

(use-package! nix-repl
  :commands nix-repl-show)
