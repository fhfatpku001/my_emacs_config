;====================Loading path====================
(package-initialize)
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;====================System auto-settings=============
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-source-correlate-mode t)
 '(TeX-source-correlate-start-server t)
 '(TeX-view-program-selection
   (quote
    (((output-dvi has-no-display-manager)
      "dvi2tty")
     ((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "PDF Tools")
     (output-html "xdg-open"))))
 '(cua-mode t nil (cua-base))
 '(electric-pair-mode t)
 '(gdb-many-windows t)
 '(global-linum-mode t)
 '(package-selected-packages
   (quote
    (company-irony-c-headers company-irony bazel-mode doom rainbow-delimiters nlinum company-shell company-reftex company-math company-dict company-c-headers company-bibtex company-auctex company use-package doom-modeline doom-themes org-bullets yasnippet-snippets yasnippet pdf-tools auctex))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;===========================Customize settings ====================
(set-frame-font "9" nil t)
;(desktop-save-mode 1) ;自动打开上次文件
(setq inhibit-startup-message t);关闭启动画面
(setq global-linum-mode t); 左侧边栏显示行号
;(setq column-number-mode t);显示行列号
;(setq line-number-mode t)
(setq paren-mode t);括号匹配
;(setq show-paren-style 'parentheses);括号匹配风格
(display-time-mode t);显示时间
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)	
(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill);Auctex-mode 自动换行
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'LaTex-mode-hook  (lambda () (linum-mode t)))
 	
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time

 (when window-system (set-frame-size (selected-frame) 80 96))

;==========================YASnippet=========================
(require 'yasnippet)
(yas-global-mode 1)
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "<C-tab>") 'yas-expand)

;======================= Org-mode ===========================

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(global-set-key "\C-ca" 'org-agenda)

;====================Doom-Theme ====================
(require 'doom-themes)

;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each
;; theme may have their own settings.
(load-theme 'doom-vibrant t)

;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)

;; Enable custom neotree theme
(doom-themes-neotree-config)  ; all-the-icons fonts must be installed!

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

(require 'doom-modeline)
(doom-modeline-mode 1)

;=======================COMPANY MODE=====================
(require 'use-package)
(use-package company
	     :ensure t
	     :config
	     (setq company-idle-delay 0.35)
	     (setq company-minimum-prefix-length 2))

(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))
 
(use-package company-irony
	     :ensure t
	     :config
	     (require 'company)
	     (add-to-list 'company-backend 'company-irony))

(use-package irony
	     :ensure t
	     :config
	     (add-hook 'c++-mode-hook 'irony-mode)
	     (add-hook 'c-mode-hook 'irony-mode)
	     (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(add-hook 'after-init-hook 'global-company-mode)
(require 'company-auctex)
(company-auctex-init)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "<return>") nil)
  (define-key company-active-map (kbd "RET") nil)
  (define-key company-active-map (kbd "SPC") #'company-complete-selection))

;=========================CUA============================

(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1) ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t) ;; Standard Windows behaviour

;=====================PDF-tools ===================

(pdf-tools-install)
(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)

;==========================Rainbow-delimiters====================
; This mode is to color parenthesis w.r.t its depth
(add-hook 'latex-mode-hook #'rainbow-delimiters-mode)
(add-hook 'c++-mode-hook #'rainbow-delimiters-mode)

;=======================COMPANY MODE=====================
(require 'use-package)
(add-hook 'after-init-hook 'global-company-mode)
(use-package company
	     :ensure t
	     :config
	     (setq company-idle-delay 0.35)
	     (setq company-minimum-prefix-length 2))

(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))
 
(use-package company-irony
	     :ensure t
	     :config
	     (require 'company)
	     (add-to-list 'company-backend 'company-irony))

(use-package irony
	     :ensure t
	     :config
	     (add-hook 'c++-mode-hook 'irony-mode)
	     (add-hook 'c-mode-hook 'irony-mode)
	     (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(add-hook 'after-init-hook 'global-company-mode)
(require 'company-auctex)
(company-auctex-init)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "<return>") nil)
  (define-key company-active-map (kbd "RET") nil)
  (define-key company-active-map (kbd "SPC") #'company-complete-selection))

(global-set-key (kbd "<f5>") #'compile)
(setq compilation-read-command nil)
;=============================nlinum mode========================

(defun my-nlinum-mode-hook ()
  (when nlinum-mode
    (setq-local nlinum-format
                (concat "%" (number-to-string
                             ;; Guesstimate number of buffer lines.
                             (ceiling (log (max 1 (/ (buffer-size) 80)) 10)))
                        "d"))))
(add-hook 'nlinum-mode-hook 'my-nlinum-mode-hook)

