(eval-when-compile
  (require 'init-const)
  (require 'init-global-config)
  (require 'init-func))

;; AUCTeXPac
(use-package tex
  :ensure auctex
  :defer t
  :custom
  (TeX-auto-save t)
  (TeX-parse-self t)
  (TeX-master nil)
;;;; to use pdfview with auctex
;;  (TeX-view-program-selection '((output-pdf "pdf-tools"))
;;                              TeX-source-correlate-start-server t)
;;  (TeX-view-program-list '(("pdf-tools" "TeX-pdf-tools-sync-view")))
;;  (TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)
;; latex-preview-pane is a minor mode for Emacs that enables you 
;;to preview your LaTeX files directly in Emacs.
;;

(eval-after-load 'tex
  '(progn
     (assq-delete-all 'output-pdf TeX-view-program-selection)
     (add-to-list 'TeX-view-program-selection '(output-pdf "Sumatra PDF"))))
  :hook
  (LaTeX-mode . (lambda ()
                  (turn-on-reftex)
                  (setq reftex-plug-into-AUCTeX t)
                              (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
            (setq TeX-command-default "XeLaTeX")
            (setq TeX-save-query  nil )
            (setq TeX-show-compilation t)
                  (reftex-isearch-minor-mode)
                  (setq TeX-PDF-mode t)
                  (setq TeX-source-correlate-method 'synctex)
                  (setq TeX-source-correlate-start-server t)
				  ;; 正向与逆向搜索(只对英文目录下的tex文件，才有效)
(setq TeX-view-program-list
   '(("Sumatra PDF" ("\"C:/Users/Administrator/AppData/Local/SumatraPDF/SumatraPDF.exe\" -reuse-instance"
                      (mode-io-correlate " -forward-search %b %n ") " %o"))))))
  :config
  (when (version< emacs-version "26")
    (add-hook LaTeX-mode-hook #'display-line-numbers-mode)))
;; -AUCTeXPac

(provide 'init-latex)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-latex.el ends here
