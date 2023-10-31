(defun my-get-search-query ()
  (if (doom-region-active-p) (regexp-quote (doom-thing-at-point-or-region)) (thing-at-point 'symbol t)))

(defun my-vertico-search-dir (&optional with-input)
  (interactive)
  (let ((query (and with-input (my-get-search-query))))
    (consult-ripgrep default-directory query))
  )

(defun my-vertico-search-dir-with-input ()
  (interactive)
  (my-vertico-search-dir t))

(defun my-vertico-search-file (&optional with-input)
  (interactive)
  (let* ((fname (file-name-nondirectory (buffer-file-name)))
         ;; Pass fname as an expression to avoid it being split by spaces.
         (consult-ripgrep-args `(,consult-ripgrep-args "-g" fname))
         (query (when with-input
                            (my-get-search-query)
                          )))
    (consult-ripgrep default-directory query))
  )

(defun my-vertico-search-file-with-input ()
  (interactive)
  (my-vertico-search-file t))

(map!
 :leader
 :after consult
 :desc "Search in dir" "sd" #'my-vertico-search-dir
 :desc "Search in dir with things at point" "sD" #'my-vertico-search-dir-with-input
 :desc "Search in file" "ss" #'my-vertico-search-file
 :desc "Search in file with things at point" "sS" #'my-vertico-search-file-with-input
 )

(map!
 :after vertico
 :map vertico-map
 "<next>" #'vertico-scroll-up
 "<prior>" #'vertico-scroll-down
 "C-l" #'vertico-directory-up
 "C-p" #'previous-history-element
 "C-n" #'next-history-element
 "C-k" 'kill-line)
