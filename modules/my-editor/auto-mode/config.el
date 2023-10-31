;; Patch auto-mode-alist to inspect extensions that's not at the end
(defvar my--auto-mode-alist-has-been-patched nil)
(unless my--auto-mode-alist-has-been-patched
  (setq my--auto-mode-alist-has-been-patched t)
  (let ((patched-auto-mode-alist-jinja (mapcar
                                        (lambda (pr) (let ((pattern (car pr))
                                                           (mode (cdr pr)))
                                                       (cons (replace-regexp-in-string "\\\\\'" (lambda (s) (concat "\\.jinja" s)) pattern nil t) mode))) auto-mode-alist)) )
    (setq auto-mode-alist (append auto-mode-alist patched-auto-mode-alist-jinja))))
