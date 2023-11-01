;;; my-lang/cc/config.el -*- lexical-binding: t; -*-

(when (modulep! +lsp)
  (add-hook! '(c-mode-local-vars-hook
               c++-mode-local-vars-hook
               cmake-mode-local-vars-hook)
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