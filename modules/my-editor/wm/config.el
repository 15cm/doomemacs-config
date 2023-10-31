(map!
 :leader
 :desc "Ace window" ";"  #'ace-window)

(defun my-treemacs-select-window ()
  (interactive)
  (require 'treemacs)
  (pcase (treemacs-current-visibility)
    (`visible (treemacs-select-window))
    (_ (+treemacs/toggle))))

(map!
 :leader
 "ft" #'my-treemacs-select-window
 "fT" #'+treemacs/toggle
 "f<" #'treemacs-find-file)
