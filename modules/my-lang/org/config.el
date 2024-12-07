(when (modulep! +roam)
  (after! (org-roam org)
    (setq org-roam-directory org-directory)
    ;; Pin the org attach dir to file level id to avoid org looking into header
    ;; level id
    ;; https://emacs.stackexchange.com/questions/69862/how-to-enable-org-mode-to-search-attachment-in-parent-headers-attachment-folder
    (setq org-roam-capture-templates
          '(("d" "default" plain
             "%?"
             :if-new (file+head "${slug}-%<%Y%m%d%H%M%S>.org"
                                ":PROPERTIES:
:DIR:      %(replace-regexp-in-string (expand-file-name org-directory) \"\" (org-attach-dir-from-id (org-roam-node-id org-roam-capture--node)))
:END:
#+title: ${title}\n")
             :immediate-finish t
             :unnarrowed t)))
    ))

;; :DIR:      %(replace-regexp-in-string (expand-file-name org-directory) "" (org-attach-dir-from-id (org-roam-node-id org-roam-capture--node)))
(use-package! my-org-blog
  :defer t
  :commands (my-org-blog-post-buffer)
  :init
  (setq my-org-blog-post-project-root (expand-file-name "~/tech/15cm-site/blog"))
  (map! :after org :map org-mode-map :localleader ">" #'my-org-blog-post-buffer)
  )

(use-package! org-download)

;; unmap all existing "r kbd".
(after! org
  (let ((prefix "r"))
    (dolist (key (mapcar #'string (number-sequence 32 126)))
      (map! :map org-mode-map :localleader :prefix prefix key nil)))
  (setq org-attach-id-dir "data/"))

(map! :after (org org-roam)
      :map org-mode-map
      :localleader
      (:prefix ("r" . "org-roam")
               "D" #'org-roam-demote-entire-buffer
               "f" #'org-roam-node-find
               "F" #'org-roam-ref-find
               "g" #'org-roam-graph
               "i" #'org-roam-node-insert
               "I" #'org-id-get-create
               "m" #'org-roam-buffer-toggle
               "M" #'org-roam-buffer-display-dedicated
               "c" #'org-roam-capture
               "r" #'org-roam-refile
               "R" #'org-roam-link-replace-all
               (:prefix ("d" . "by date")
                :desc "Goto previous note" "b" #'org-roam-dailies-goto-previous-note
                :desc "Goto date"          "d" #'org-roam-dailies-goto-date
                :desc "Capture date"       "D" #'org-roam-dailies-capture-date
                :desc "Goto next note"     "f" #'org-roam-dailies-goto-next-note
                :desc "Goto tomorrow"      "m" #'org-roam-dailies-goto-tomorrow
                :desc "Capture tomorrow"   "M" #'org-roam-dailies-capture-tomorrow
                :desc "Capture today"      "n" #'org-roam-dailies-capture-today
                :desc "Goto today"         "t" #'org-roam-dailies-goto-today
                :desc "Capture today"      "T" #'org-roam-dailies-capture-today
                :desc "Goto yesterday"     "y" #'org-roam-dailies-goto-yesterday
                :desc "Capture yesterday"  "Y" #'org-roam-dailies-capture-yesterday
                :desc "Find directory"     "-" #'org-roam-dailies-find-directory)
               (:prefix ("o" . "node properties")
                        "a" #'org-roam-alias-add
                        "A" #'org-roam-alias-remove
                        "t" #'org-roam-tag-add
                        "T" #'org-roam-tag-remove
                        "r" #'org-roam-ref-add
                        "R" #'org-roam-ref-remove))
      (:prefix ("f" . "refile")
               "." #'+org/refile-to-current-file
               "c" #'+org/refile-to-running-clock
               "l" #'+org/refile-to-last-location
               "f" #'+org/refile-to-file
               "o" #'+org/refile-to-other-window
               "O" #'+org/refile-to-other-buffer
               "v" #'+org/refile-to-visible
               "r" #'org-refile
               "R" #'org-refile-reverse))

(after! (org-cliplink)
  (setq org-cliplink-simpleclip-source t))
