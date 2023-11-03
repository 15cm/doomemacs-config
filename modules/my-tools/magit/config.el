;;; my-tools/magit/config.el -*- lexical-binding: t; -*-

(after! git-commit
  (setq git-commit-finish-query-functions
        (remove 'git-commit-check-style-conventions
                git-commit-finish-query-functions))
  )
