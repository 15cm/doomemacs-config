;;; my-lang/rust/config.el -*- lexical-binding: t; -*-

(use-package! rust-mode
  :mode ("\\.rs$" . rust-mode)
  :config
  (when (modulep! +lsp)
    (add-hook 'rust-mode-hook #'lsp! 'append)
    (my-common-lsp-mode-map! (rust-mode-map)))
  )
