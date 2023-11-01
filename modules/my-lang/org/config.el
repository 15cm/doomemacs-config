(when (modulep! +roam)
  (after! (org-roam org)
    (setq org-roam-directory org-directory)))

(use-package! my-org-blog
  :defer t
  :commands (my-org-blog-post-buffer)
  :init
  (setq my-org-blog-post-project-root (expand-file-name "~/tech/15cm-site/blog"))
  (map! :localleader :map org-mode-map ">" #'my-org-blog-post-buffer)
  )
