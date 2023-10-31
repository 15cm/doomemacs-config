;;; editor/clipboard/config.el -*- lexical-binding: t; -*-

(use-package! simpleclip
  :init
  (setq select-enable-clipboard nil)
  :config
  (simpleclip-mode 1)
  (when (executable-find "copyq")
    (setq simpleclip-custom-content-provider "copyq clipboard")))

(defun my-copy-kill-ring-to-clipboard()
  "Copy the first item of kill ring to clipboard"
  (interactive)
  (let ((copy-cmd (if IS-MAC "nc localhost 8377" "nc -N localhost 8377"))
        (kill-ring-str (substring-no-properties (car kill-ring))))
    (with-temp-buffer
      (insert kill-ring-str)
      (shell-command-on-region (point-min) (point-max) copy-cmd))
    (message "Yanked kill ring to clipboard!")))

(defun my-copy-selection-to-clipboard ()
  "Copy selected region to system clipboard."
  (interactive)
  (let ((copy-cmd (if IS-MAC "nc localhost 8377" "nc -N localhost 8377")))
    (if (region-active-p)
        (progn
          (shell-command-on-region (region-beginning) (region-end) copy-cmd)
          (message "Yanked selected region to clipboard!")
          (deactivate-mark))
      (message "No region active; can't yank to clipboard!"))
    )
  )

(defun my-paste-from-clipboard ()
  "Pastes from system clipboard."
  (interactive)
  ;; Override the default-directory to avoid tramp mode pasting using remote commands.
  (let ((default-directory temporary-file-directory))
    (if IS-MAC
        (insert (shell-command-to-string "pbpaste"))
      (simpleclip-paste))))

(define-key evil-visual-state-map (kbd "C-y") #'my-copy-selection-to-clipboard)
(define-key evil-normal-state-map (kbd "C-y") #'my-copy-kill-ring-to-clipboard)
(global-set-key (kbd (if IS-MAC "s-v" "C-S-v")) #'my-paste-from-clipboard)
(global-set-key (kbd "M-c") 'consult-yank-from-kill-ring)
