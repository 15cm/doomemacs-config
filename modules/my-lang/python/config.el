;; Fork from Spacemacs
(defun my-python-start-or-switch-repl ()
  "Start and/or switch to the REPL."
  (interactive)
  (let ((shell-process
         (or (python-shell-get-process)
             ;; `run-python' has different return values and different
             ;; errors in different emacs versions. In 24.4, it throws an
             ;; error when the process didn't start, but in 25.1 it
             ;; doesn't throw an error, so we demote errors here and
             ;; check the process later
             (with-demoted-errors "Error: %S"
               ;; in Emacs 24.5 and 24.4, `run-python' doesn't return the
               ;; shell process
               (call-interactively #'run-python)
               (python-shell-get-process)))))
    (unless shell-process
      (error "Failed to start python shell properly"))
    (pop-to-buffer (process-buffer shell-process))
    (evil-insert-state)))

(when (modulep! +lsp)
  (use-package! lsp-pyright
    :after python
    :config
    (add-hook 'python-mode-hook #'lsp! 'append)
    (my-common-lsp-mode-map! (python-mode-map))
    (map! :localleader :map (python-mode-map)
          "'" #'my-python-start-or-switch-repl
          (:prefix ("s" . "send")
                   "r" #'python-shell-send-region
                   "b" #'python-shell-send-buffer
                   "s" #'python-shell-send-statement))
    ))

(when (modulep! +tree-sitter)
  (add-hook 'python-mode-local-vars-hook #'tree-sitter! 'append))


(setq python-shell-interpreter "pdm")
(setq python-shell-interpreter-args "run python")
