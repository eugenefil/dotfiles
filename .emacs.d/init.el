;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'package) ; w/out this package-archives is void
;; ELPA is an official gnu repo and a standard interface for other
;; emacs repos. It is in `package-archives' by default. ELPA is
;; restricted to only free software and requires signing FSF
;; Copyright. Thus ELPA contains the fewest packages of all repos.
;;
;; Marmalade does not require FSF Copyright. It is served by elnode
;; web server written by Nic Ferrier.
;;
;; MELPA is not restricted to free software. Packages are not uploaded
;; but built automatically from upstream with recipes. There are
;; stable versions (melpa-stable) and bleeding edge (melpa).
;; (add-to-list 'package-archives
;; 	     '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)


(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(setq inhibit-splash-screen t)

(column-number-mode 1)
(transient-mark-mode 0)
(setq enable-recursive-minibuffers t)
(setq history-delete-duplicates t)
(setq kill-whole-line t)
(setq save-interprogram-paste-before-kill t)
(setq scroll-preserve-screen-position t)
(setq read-quoted-char-radix 16)
(setq isearch-allow-scroll t)

;; Completion.
(add-to-list 'completion-styles 'substring t)
(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)
(setq completion-cycle-threshold 5)
(icomplete-mode)

(load-theme 'zenburn-my t)
(setq visible-bell 1)
(setq ediff-split-window-function 'split-window-horizontally)

; open man page in current window
(setq Man-notify-method 'pushy)
; select window of help page
(setq help-window-select t)

;; make ascii selection overlay brighter
(add-hook 'hexl-mode-hook
	  (lambda ()
	    (overlay-put hexl-ascii-overlay 'face 'holiday)))

;; dired
;; use 'a' to enter subdirs instead of 'enter', use '^' to move up
(put 'dired-find-alternate-file 'disabled nil)
(add-hook 'dired-mode-hook
 (lambda ()
  (define-key dired-mode-map (kbd "^")
    (lambda () (interactive) (find-alternate-file "..")))
  ; was dired-up-directory
  ))

(setq shell-pushd-regexp "pu")
(setq shell-popd-regexp "po")
(setq shell-input-autoexpand nil)

;; ;; functions for remote python execution via tramp
;; ;;;###tramp-autoload
;; (defun tramp-make-tramp-temp-name (vec)
;;   "Generate a temporary file name on the remote host identified
;; by VEC."
;;   (let ((prefix (expand-file-name
;; 		 tramp-temp-name-prefix (tramp-get-remote-tmpdir vec)))
;; 	result)
;;     (while (not result)
;;       ;; `make-temp-file' would be the natural choice for
;;       ;; implementation.  But it calls `write-region' internally,
;;       ;; which also needs a temporary file - we would end in an
;;       ;; infinite loop.
;;       (setq result (make-temp-name prefix))
;;       (if (file-exists-p result)
;; 	  (setq result nil)))
;;     result))

;; (defun py--execute-buffer-finally (strg which-shell proc procbuf origline)
;;   (let* ((tempfile (tramp-make-tramp-temp-name
;; 		    (tramp-dissect-file-name default-directory)))
;; 	 (localname (tramp-file-name-localname
;; 		     (tramp-dissect-file-name tempfile)))
;;          (tempbuf (get-buffer-create tempfile))
;; 	 erg)
;;     (setq py-tempfile tempfile)
;;     (with-current-buffer tempbuf
;;       (insert strg)
;;       (write-file py-tempfile))
;;     (kill-buffer tempbuf)
;;     (unwind-protect
;; 	(setq erg (py--execute-file-base proc localname nil procbuf origline)))
;;     erg))

;; w3m
;; (require 'w3m-load)
;; (setq w3m-default-display-inline-images t)
;; (setq w3m-session-load-last-sessions t)

;; slime
;; (require 'slime-autoloads)
;; (setq inferior-lisp-program "/usr/bin/clisp")

;; tramp
(setq tramp-default-method "ssh")
;; don't create .tramp_history files on remote machines
(setq tramp-histfile-override "/dev/null")

;;; org
;; org-mode-hook is defined only after org-mode was loaded
(eval-after-load "org"
  '(progn
     (add-hook 'org-mode-hook 'toggle-truncate-lines t)
     (add-hook 'org-agenda-mode-hook 'toggle-truncate-lines t)
     (setq org-todo-keywords
	   '((sequence "TODO" "|" "DONE" "DROP")))
     (setq org-todo-keyword-faces '(("DROP" . "grey")))
     (setq org-adapt-indentation nil)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ediff-even-diff-A ((t (:extend t :background "dark gray"))))
 '(ediff-even-diff-B ((t (:extend t :background "dark gray"))))
 '(ediff-fine-diff-B ((t (:background "forest green"))))
 '(ediff-odd-diff-A ((t (:extend t :background "dark gray"))))
 '(ediff-odd-diff-B ((t (:extend t :background "dark gray"))))
 '(org-level-5 ((t (:inherit outline-5 :foreground "hot pink")))))

(put 'erase-buffer 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)

(projectile-mode)

;; in addition to clipboard, copy to primary selection (needed for
;; pasting in xterm)
(setq select-enable-primary t)

(require 'rcirc)
(setq rcirc-default-nick "eugenefil")
;; (setq rcirc-server-alist
;;       '(("irc.freenode.net"
;; 	 :channels ("#minetest" "#minetest-dev" "#minetest-hub"))))

(require 'eglot)
;; shadow ccls w/ clangd for c and c++ modes
(add-to-list 'eglot-server-programs '((c++-mode c-mode) . ("clangd")))
(add-hook 'c++-mode-hook 'eglot-ensure)

;; make tag search case-sensitive in programming modes, otherwise
;; xref-find-definitions for e.g. PAGE_OFFSET also finds definitions
;; like `struct page_offset'
(add-hook 'prog-mode-hook (lambda () (setq tags-case-fold-search nil)))

;; open openrc initd scripts in sh-mode
(add-to-list 'interpreter-mode-alist '("openrc-run" . sh-mode))

;; open Makefile-like filenames in gnumake mode (useful for various
;; makefiles in kernel source for example)
(add-to-list 'auto-mode-alist '("[Mm]akefile\\(\\..*\\)?$" . makefile-gmake-mode))

(require 'desktop)
;; frameset-filter-alist shares value with
;; frameset-persistent-filter-alist, so copy it before modifying
(setq frameset-filter-alist (copy-tree frameset-filter-alist))
;; set 'name func to nil, so frame names are saved when saving desktop
;; (see frameset-save, which is indirectly called by desktop-save)
(setf (cdr (assoc 'name frameset-filter-alist)) nil)
(add-to-list 'desktop-globals-to-save 'xref--marker-ring)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(c-default-style
   '((c-mode . "linux")
     (c++-mode . "linux")
     (java-mode . "java")
     (awk-mode . "awk")
     (other . "gnu")))
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-enabled-themes '(zenburn-my))
 '(custom-safe-themes
   '("8dc48a77bf1b4c73b6ecadc2326913cae5e68782b2710f0ca48e291d06bd20a3" "da8bd06ec77719822d8217e219aa686699118e00b3337dab9fa5ea288f327389" "86bcbef8618aec51569bca61688d697a63c9c96c597375ea97adbde6e0374793" "84890723510d225c45aaff941a7e201606a48b973f0121cb9bcb0b9399be8cba" default))
 '(fci-rule-color "#383838")
 '(lua-indent-level 8)
 '(nrepl-message-colors
   '("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3"))
 '(org-agenda-window-setup 'other-window)
 '(org-startup-folded t)
 '(package-selected-packages
   '(magit yaml-mode projectile eglot lua-mode cython-mode markdown-mode))
 '(pdf-view-midnight-colors '("#DCDCCC" . "#383838"))
 '(sh-basic-offset 8)
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   '((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3")))
 '(vc-annotate-very-old-color "#DC8CC3"))

(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-11"))
(add-to-list 'default-frame-alist '(fullscreen . maximized))


;; duplicate common keys to reduce errors
(global-set-key (kbd "C-x b") 'switch-to-buffer)
(global-set-key (kbd "C-x C-b") 'switch-to-buffer)
(global-set-key (kbd "C-x f") 'find-file)
(global-set-key (kbd "C-x C-f") 'find-file)
;; also don't query buffer, just kill current
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-x C-k") 'kill-this-buffer)


;; load combo translations from russian layout to english
(load-file (concat user-emacs-directory "translate.el"))

;; remap C-u to C-x
(define-key key-translation-map (kbd "C-u") (kbd "C-x"))
(define-key key-translation-map (kbd "C-S-u") (kbd "C-x"))
(define-key key-translation-map (kbd "C-о") (kbd "C-x"))
(define-key key-translation-map (kbd "C-О") (kbd "C-x"))
;; remap C-. to C-u
(define-key key-translation-map (kbd "C-.") (kbd "C-u"))
;; no C-S-.
(define-key key-translation-map (kbd "C-я") (kbd "C-u"))
(define-key key-translation-map (kbd "C-Я") (kbd "C-u"))
;; remap C-x to C-h
(define-key key-translation-map (kbd "C-x") (kbd "C-h"))
(define-key key-translation-map (kbd "C-S-x") (kbd "C-h"))
(define-key key-translation-map (kbd "C-ю") (kbd "C-h"))
(define-key key-translation-map (kbd "C-Ю") (kbd "C-h"))
;; remap C-h to DEL
(define-key key-translation-map (kbd "C-h") (kbd "DEL"))
(define-key key-translation-map (kbd "C-S-h") (kbd "DEL"))
(define-key key-translation-map (kbd "C-н") (kbd "DEL"))
(define-key key-translation-map (kbd "C-Н") (kbd "DEL"))
;; remap M-h to M-DEL
(define-key key-translation-map (kbd "M-h") (kbd "M-DEL"))
(define-key key-translation-map (kbd "M-H") (kbd "M-DEL"))
(define-key key-translation-map (kbd "M-н") (kbd "M-DEL"))
(define-key key-translation-map (kbd "M-Н") (kbd "M-DEL"))


;;; Backups
;; These settings are primarily intended for editing config
;; files. They are edited rarely and not under vc, so backups are
;; welcome.

;; don't break hard links when creating backup, otherwise they point
;; to backup, not the original file
(setq backup-by-copying-when-linked t)
;; numbered backups allow many backups instead of just one with simple
;; backups
(setq version-control t)
;; store all backups under emacs dir to avoid littering
(add-to-list 'backup-directory-alist
	     `("." . ,(concat user-emacs-directory "backup")))
;; Keep one oldest backup (the very original) and nine
;; newest. Silently delete excessive.
(setq kept-old-versions 1
      kept-new-versions 9
      delete-old-versions t)

(when (package-installed-p 'mu4e)
  (require 'mu4e)
  (setq mail-user-agent 'mu4e-user-agent)
  (setq user-mail-address "e.filimonov@philipp-kld.ru"
	user-full-name "Евгений Филимонов")
  ;; kill compose buffer after sending message
  (setq message-kill-buffer-on-exit t)
  (setq
   mu4e-headers-fields '((:human-date . 12) (:flags . 6) (:from . 22) (:subject))
   mu4e-attachment-dir  "~/dl"
   mu4e-view-show-images t ; show images in messages
   mu4e-get-mail-command "getmail -r wph"
   mu4e-update-interval 600
   ;; show duplicates, otherwise it's not clear why mu4e shows less
   ;; messages than mu-find
   mu4e-headers-skip-duplicates nil
   ;; don't show related and threads, keep things simple
   mu4e-headers-include-related nil
   mu4e-headers-show-threads nil)
  (setq send-mail-function 'smtpmail-send-it
	smtpmail-smtp-server "10.0.0.1"))


(defun winselector-winlist ()
  (sort (window-list-1)
	(lambda (a b)
	  (let ((arect (window-edges a))
		(brect (window-edges b)))
	    (or (< (car arect) (car brect))
		(and (= (car arect) (car brect))
		     (< (cadr arect) (cadr brect))))))))

;; bind keys for window selection
(dotimes (i 7)
  (let* ((k (1+ i))
	 (name (intern (format "winselector-select-%d" k))))
    (eval `(defun ,name ()
	     ,(format "Select window with number %d.
Windows are numbered left to right, then top to bottom.
Left-most upper window is number 1." k)
	     (interactive)
	     (select-window (nth ,i (winselector-winlist)))))
    (global-set-key (kbd (format "M-%d" k)) name)))

;; diff-mode-map inherits from diff-mode-shared-map, which
;; inherits from special-mode-map, which uses suppress-keymap to
;; construct the map, which shadows global M-%d keys with
;; digit-argument, so we explicitly overwrite them for diff-mode
(add-hook 'diff-mode-hook
	  (lambda ()
	    (define-key diff-mode-map (kbd "M-1") 'winselector-select-1)
	    (define-key diff-mode-map (kbd "M-2") 'winselector-select-2)
	    (define-key diff-mode-map (kbd "M-3") 'winselector-select-3)
	    (define-key diff-mode-map (kbd "M-4") 'winselector-select-4)
	    (define-key diff-mode-map (kbd "M-5") 'winselector-select-5)
	    (define-key diff-mode-map (kbd "M-6") 'winselector-select-6)
	    (define-key diff-mode-map (kbd "M-7") 'winselector-select-7)))


(defun startup ()
  (split-window-right)
  (shell)
  (rename-buffer "2")
  (shell)
  (rename-buffer "1"))
(startup)
