;;; my-lang/cc/config.el -*- lexical-binding: t; -*-

(use-package! cc-mode
  :config
  (when (modulep! +lsp)
    (add-hook! '(c-mode-hook
                 c++-mode-hook
                 cmake-mode-hook)
               :append #'lsp!)

    (defun my-lsp-clangd-find-other-file ()
      (interactive)
      (lsp-clangd-find-other-file 'new-window))

    (my-common-lsp-mode-map! (c-mode-map c++-mode-map))
    (map! :localleader :map (c-mode-map c++-mode-map)
          (:prefix ("g" . "goto")
                   "a" #'lsp-clangd-find-other-file
                   "A" #'my-lsp-clangd-find-other-file))
    )

  (when (modulep! +tree-sitter)
    (add-hook! '(c-mode-local-vars-hook
                 c++-mode-local-vars-hook)
               :append #'tree-sitter!))
  (add-hook! (c-mode-hook c++-mode-hook) (setq-local c-basic-offset 2)))
