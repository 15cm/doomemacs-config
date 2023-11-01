(when (modulep! +lsp)
  (use-package! lsp-pyright
    :after python
    :config
    (add-hook 'python-mode-hook #'lsp! 'append)
    (my-common-lsp-mode-map! (python-mode-map))
    ))
