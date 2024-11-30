;;; my-tools/lsp/config.el -*- lexical-binding: t; -*-


(defun my-lsp-find-definition-other-window ()
  (interactive)
  (lsp-find-definition :display-action 'window))

(defmacro my-common-lsp-mode-map! (&rest maps)
  `(map! :localleader :map ,@maps
         (:prefix ("g" . "goto")
                  "d" #'lsp-find-definition
                  "D" #'my-lsp-find-definition-other-window
                  "r" #'lsp-find-references)
         (:prefix ("f" . "format")
                  "f" #'lsp-format-buffer
                  "F" #'lsp-format-region)))

(after! lsp (setq lsp-enable-file-watchers nil))
