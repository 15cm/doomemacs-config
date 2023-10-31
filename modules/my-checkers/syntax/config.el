(defvar my-error-map (make-sparse-keymap) "My error key map")

(map!
 (:after flycheck
         (:map my-error-map
               "l" #'flycheck-list-errors
               "n" #'flycheck-next-error
               "p" #'flycheck-previous-error))
 :leader
 :desc "error" "e" my-error-map)
