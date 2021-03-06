;; .emacs

;; load minimum settings
(load-file "~/.emacs.d/min-settings.el")

;; customisations global
(setq custom-font-size 143)
(setq custom-accent-color-graphics "#54AFFF") ;; #2395FF") ;; #0080ff") ;; blue
(setq custom-accent-color-terminal "#ff9f00") ;; "#ff8c00") ;; DarkOrange
(setq custom-theme-color "dark") ;; dark or light
(setq compile-cores-str "4")

;; customisations per machine
(when (string-equal system-name "JOJO-PC") (setq custom-font-size 100))
(when (string-equal system-name "JOJO-LAPTOP")
  (setq compile-cores-str "8")
  (setq custom-font-size 100)
  (setq custom-theme-color "dark"))
(when (string-equal system-name "DESKTOP-OC9IKE6") (setq custom-font-size 95))
(when (string-equal system-name "xoaltecuhtli") (setq custom-font-size 110))
(when (string-equal system-name "malte") (setq custom-font-size 143))
(when (string-equal system-name "ATLANTIS") (setq custom-theme-color "light"))
(when (string-equal system-name "SUSAK")
  (setq custom-font-size 90)
  (setq custom-theme-color "light")
  )

(setq font-size-reset custom-font-size)

(defun my-machines ()
  (or
   (string-equal system-name "JOJO-PC")
   (string-equal system-name "JOJO-LAPTOP")
  ))

(defun is-theme-dark ()
  (string-equal custom-theme-color "dark")
  )

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("58a2e993177ddc35dfe4cc241c0e4494c083b7e3f479e49e0f0d7e8bb675c626" "fa116d8cc5b249705e891486cb07783f7f9106e71a9199c15c355e83ccf455a1" default))
 '(inhibit-startup-screen t))

;; show line numbers only for 'files', not dynamic buffers
;; (global-linum-mode t)
(add-hook 'find-file-hook 'linum-mode)
(if (display-graphic-p)
    (setq linum-format "%3d ")
  (setq linum-format "%3d ") ; │
  )
; character search https://unicode-search.net/unicode-namesearch.pl?term=VERTICAL
(hlinum-activate) ;; for custom color of current line number

;; custom script directory
(add-to-list 'load-path "~/.emacs.d/lisp/")

(when (display-graphic-p)
  ;; My preferred FONT
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   ;; '(default ((t (:family "DejaVu Sans Mono" :foundry "outline" :slant normal :weight normal :height 90 :width normal))))
   '(default ((t (:family "Lucida Console" :foundry "B&H " :slant normal :weight normal :height 140 :width semi-condensed))))
   ;; '(default ((t (:family "Menlo" :foundry "outline" :slant normal :weight normal :height 90 :width normal))))
   ;; '(scroll-bar ((t (:background "black" :foreground "black" :width condensed)))) ;; no effect on Windows
  )
  ;; mouse-paste at emacs-cursor, not at mouse-cursor
  (setq mouse-yank-at-point t)

  ;; Scrolling https://gist.github.com/dragonwasrobot/3716926
  (setq scroll-step 1)
  (setq scroll-conservatively 1000)
  (setq mouse-wheel-scroll-amount '(3 ((shift) . 10)))
  (setq mouse-wheel-progressive-speed nil)
  (setq mouse-wheel-follow-mouse t)

  ;; Emojis
  (add-hook 'after-init-hook #'global-emojify-mode)

  ;; Text Size
  (defun apply-zoom-text ()
    (set-face-attribute 'default nil :height custom-font-size))
  (defun zoom-text (amount)
    (setq custom-font-size (+ amount custom-font-size))
    (apply-zoom-text))
  (defun zoom-text-increase ()
    (interactive)
    (zoom-text 6))
  (defun zoom-text-decrease ()
    (interactive)
    (zoom-text -6))
  (defun zoom-text-reset ()
    (interactive)
    (setq custom-font-size font-size-reset)
    (apply-zoom-text))
  )

(unless (display-graphic-p)
  ;; xterm-mouse-mode: needed for move cursor with pointer click
  ;; xterm-mouse-mode: needed for scrolling with mouse wheel
  ;; xterm-mouse-mode: breaks "copy from windows with mouse3"
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] 'scroll-down-line)
  (global-set-key [mouse-5] 'scroll-up-line)

  ;; Terminal Title https://www.emacswiki.org/emacs/FrameTitle#toc5
  ;; (unless (my-machines) ; broken on WSL, msys, cygwin
  ;;   (require 'xterm-title)
  ;;   (xterm-title-mode 1)
  ;;   )
  )

;; Frame Title https://www.emacswiki.org/emacs/FrameTitle
(setq frame-title-format '("%b"))

;; Indentation / Tabs / Spaces
;; https://www.emacswiki.org/emacs/NoTabs
;; https://www.emacswiki.org/emacs/IndentationBasics
;; https://www.emacswiki.org/emacs/IndentingC
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default c-basic-offset 4)
(setq c-default-style "k&r")
(c-set-offset 'inline-open '0)

;; show matching brace / paren
;; https://www.emacswiki.org/emacs/ShowParenMode
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Matching.html
(show-paren-mode 1)
(setq show-paren-when-point-inside-paren 1)

;; custom themes directory
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;; auto install packages
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;; (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
;; (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
;; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

;; Mode line setup
(setq-default mode-line-format '(
   (:propertize "    %b" face mode-line-filename-face)
   "  "
   (:eval
    (cond
     (buffer-read-only
      (propertize "RO" 'face 'mode-line-read-only-face))
     ((buffer-modified-p)
      ;; (propertize " ** " 'face 'mode-line-modified-face))
      (cond
       ((buffer-file-name)
        (propertize " ** " 'face 'mode-line-modified-face))))
     (t " -- ")))
   (vc-mode vc-mode)
   " ("
   (:propertize mode-name face mode-line-mode-face )
   ") "
   (:propertize mode-line-process)
   "                    "
   (:propertize " [ %l : %c ] " face mode-line-position-face)
   ))
(make-face 'mode-line-read-only-face)
(make-face 'mode-line-modified-face)
(make-face 'mode-line-folder-face)
(make-face 'mode-line-filename-face)
(make-face 'mode-line-position-face)
(make-face 'mode-line-mode-face)
(make-face 'mode-line-minor-mode-face)
(make-face 'mode-line-process-face)
(set-face-attribute 'mode-line-filename-face nil
            :inherit 'mode-line-face
            :weight 'bold)
(set-face-attribute 'mode-line-position-face nil
            :inherit 'mode-line-face
            ;; :weight 'bold ;; broken, chars are cut-off / mangled
            )
(set-face-attribute 'mode-line-read-only-face nil
            :inherit 'mode-line-face
            :foreground "#4271ae"
            :box '(:line-width 2 :color "#4271ae"))
(set-face-attribute 'mode-line-modified-face nil
            :inherit 'mode-line-face
            :foreground "Black"
            :background "Red")
(set-face-attribute 'mode-line-folder-face nil
            :inherit 'mode-line-face)
(set-face-attribute 'mode-line-mode-face nil
            :inherit 'mode-line-face)
(set-face-attribute 'mode-line-minor-mode-face nil
            :inherit 'mode-line-mode-face)
(set-face-attribute 'mode-line-inactive nil ;; broken! unused
            :foreground "gray60"
            :background "gray20")

;; Load-Theme functions
(defun finish-load-theme ()
  (set-face-attribute 'linum-highlight-face nil
                      ;; :inverse-video t
                      :foreground "#fff"
                      :background "#666"
                      )
  (set-face-attribute 'region nil :inverse-video t) ; selection : invert colors
  (when (display-graphic-p)
    (set-face-attribute 'mode-line nil
                        :foreground "black"
                        :background custom-accent-color-graphics)
    (if (is-theme-dark)
        (set-face-attribute 'mode-line-inactive nil :foreground "#AAA")
      (set-face-attribute 'mode-line-inactive nil :foreground "#444")
      )
    (apply-zoom-text)
  )
  (unless (display-graphic-p)
    (set-face-attribute 'mode-line nil
                        :foreground "#000"
                        :background custom-accent-color-terminal)
    (set-face-attribute 'mode-line-inactive nil
                        :foreground "#FFF"
                        :background "#444")
  )
)

(defun load-chosen-theme()
  (if (is-theme-dark)
      ;; 0
      ;; (load-theme 'romulus) ;; mine
      (load-theme 'doom-vibrant) ;; nice but comments
      ;; 1
      ;; (load-theme 'doom-dracula) ;; nice but comments
      ;; 2
      ;; (load-theme 'doom-one) ;; nice but comments
      ;; (load-theme 'doom-snazzy) ;; nice but comments
      ;; 3
      ;; (load-theme 'doom-palenight) ;; nice but comments
      ;; (load-theme 'tango-dark) ;; nice but comments
      ;; (load-theme 'doom-moonlight) ;; nice
      ;; (load-theme 'doom-outrun-electric) ;; nice but background
      ;; (load-theme 'doom-city-lights) ;; ok
      ;; (load-theme 'doom-material) ;; ok
      ;; (load-theme 'doom-molokai)
      ;; (load-theme 'doom-monokai-spectrum)
      ;; (load-theme 'doom-old-hope)
      ;; (load-theme 'deeper-blue)
      ;; (load-theme 'doom-acario-dark)
      ;; (load-theme 'doom-gruvbox)
      ;; (load-theme 'doom-horizon)
      ;; (load-theme 'manoj-dark)
      ;; (load-theme 'doom-monokai-pro)
      ;; (load-theme 'doom-oceanic-next)
      ;; (load-theme 'doom-one-light)
    (load-theme 'romulus-light))
  (finish-load-theme)
  )

(defun switch-theme()
  (if (is-theme-dark)
      (setq custom-theme-color "light")
    (setq custom-theme-color "dark"))
  (load-chosen-theme)
  )

;; Load chosen theme
(load-chosen-theme)

;; Compilation output
;; (setq compilation-scroll-output t)
(setq compilation-scroll-output 'first-error)

;; Revert (=reload from disk) All Buffers
;; source https://emacs.stackexchange.com/a/24461
(defun reload-buffers ()
  "Refresh all open file buffers without confirmation.
Buffers in modified (not yet saved) state in emacs will not be reverted. They
will be reverted though if they were modified outside emacs.
Buffers visiting files which do not exist any more or are no longer readable
will be killed."
  (interactive)
  (dolist (buf (buffer-list))
    (let ((filename (buffer-file-name buf)))
      ;; Revert only buffers containing files, which are not modified;
      ;; do not try to revert non-file buffers like *Messages*.
      (when (and filename
                 (not (buffer-modified-p buf)))
        (if (file-readable-p filename)
            ;; If the file exists and is readable, revert the buffer.
            (with-current-buffer buf
              (revert-buffer :ignore-auto :noconfirm :preserve-modes))
          ;; Otherwise, kill the buffer.
          (let (kill-buffer-query-functions) ; No query done when killing buffer
            (kill-buffer buf)
            (message "Killed non-existing/unreadable file buffer: %s" filename))))))
  (message "Finished reverting buffers containing unmodified files.")
)

;; MinGW / MSys are broken, need this for C-x C-c to quit ->
;; (global-set-key (kbd "C-x <pause>") 'kill-emacs)

;; (setq vc-handled-backends nil) ;; NO! this removes git branch in modeline)

;; Magit
;; (global-set-key (kbd "C-c C-g") 'magit-dispatch-popup)

;; PopWin : https://github.com/evmar/config/blob/master/emacs.d/popwin.el
;; (require 'popwin)
;; (popwin-mode 1)

;; Compile and ReCompile : https://www.emacswiki.org/emacs/CompileCommand#toc4
;; auto scroll compile buffer to follow output
(setq compilation-scroll-output t)
(setq compilation-last-buffer nil)
(defun compile-again (pfx)
  """Run the same compile as the last time.
If there was no last time, or there is a prefix argument, this acts like
M-x compile.
"""
 (interactive "p")
 (save-some-buffers 1)
 ;; default compile command : enable parallelism, default to dir of current buffer
 ;; set it on first invocation of compile command, not at startup because no buffer
 (setq compile-command
       (concat
        "make -C " (file-name-directory (buffer-file-name))))
 (if (and (eq pfx 1)
      compilation-last-buffer)
     (progn
       (set-buffer compilation-last-buffer)
       (revert-buffer t t))
   (call-interactively 'compile))
 )
(setenv "MAKEFLAGS" (concat (concat "--no-print-directory -j " compile-cores-str) (getenv "MAKEFLAGS")))

;; Zeal dev doc
(let ((zeal-dir "c:/Program Files/Zeal"))
  (when (file-directory-p zeal-dir)
    (add-to-list 'exec-path zeal-dir)
    (load-file "~/.emacs.d/zeal-at-point.el")
    (bind-key* "C-z" 'zeal-at-point)))

;; add path to Unix programs : make, git
(when (display-graphic-p)
  ;; add path to git and grep for jojo-pc and jojo-laptop
  (when (string-equal system-name "JOJO-PC")
    (setenv "PATH" (concat "C:/Devel/Tools/Msys2-64/usr/bin;" (getenv "PATH")))
    )
   ;; (setenv "PATH" (concat "c:/Devel/Tools/TDM-GCC-64/bin;" (getenv "PATH"))))
  ;; jojo-laptop/MinGW ->
  (when (string-equal system-name "JOJO-LAPTOP")
    (setenv "PATH" (concat "c:/Devel/Tools/Msys2/usr/bin;" (getenv "PATH"))))
  ;; jojo-laptop/Cygwin ->
  ;; (setenv "PATH" (concat "c:/Devel/Tools/Cygwin/bin;" (getenv "PATH")))
)

;; Reload config
(defun reload-config ()
  (interactive)
  (load-file "~/.emacs"))
(bind-key* "C-S-r" 'reload-config)

;; KEY BINDINGS

;; Undo
(bind-key* "C-u" 'undo)

;; Scrolling : Ctrl-up/down scroll 1 line
(bind-key* "C-<down>" 'scroll-up-line)
(bind-key* "C-<up>" 'scroll-down-line)

;; Compile
(bind-key* "C-b" 'compile-again)
(bind-key* "C-S-b" 'compile)

;; Binding GOTO-LINE
(bind-key* "M-g" 'goto-line)

;; Previous / Next buffer
(bind-key* "M-<left>" 'previous-buffer)
(bind-key* "M-<right>" 'next-buffer)

;; Next Error
(bind-key* "C-²" 'next-error) ; azerty
(bind-key* "C-`" 'next-error) ; qwerty
(bind-key* "M-²" 'previous-error)
(bind-key* "M-`" 'previous-error)
(setq compilation-auto-jump-to-first-error t) ; auto-jump to error location on compile
(setq compilation-skip-threshold 2) ; do not auto-jump to warnings

;; Change Buffer
(bind-key* "C-v" 'switch-to-buffer)

;; IDO mode : better switch-to-buffer with choices and arrow support
(ido-mode 1)

;; Change Window : done in min-settings.el with windmove-default-keybindings

;; Resize Window https://www.emacswiki.org/emacs/WindowResize
(bind-key* "S-C-<left>" 'shrink-window-horizontally)
(bind-key* "S-C-<right>" 'enlarge-window-horizontally)
(bind-key* "S-C-<down>" 'shrink-window)
(bind-key* "S-C-<up>" 'enlarge-window)

;; Comment line
(bind-key* "C-c C-c" 'comment-line)

(when (display-graphic-p)

  ;; Change text size with Ctrl and mouse wheel
  (bind-key* "<C-mouse-4>" 'zoom-text-increase)
  (bind-key* "<C-mouse-5>" 'zoom-text-decrease)
  (bind-key* "C-=" 'zoom-text-increase) ; azerty
  (bind-key* "C-+" 'zoom-text-increase) ; qwerty
  (bind-key* "C--" 'zoom-text-decrease)
  (bind-key* "C-à" 'zoom-text-reset)    ; azerty
  (bind-key* "C-0" 'zoom-text-reset)    ; qwerty

  (bind-key* "<mouse-3>" 'mouse-buffer-menu)
  ;; mouse-buffer-menu-mode-mult : so that buffer-menu does not have submenus
  (custom-set-variables '(mouse-buffer-menu-mode-mult 99))

  ;; Switch between light and dark themes
  (bind-key* "C-<f12>" (lambda() (interactive) (switch-theme)))
  )

;; Clean-up whitespace before saving
(add-hook 'before-save-hook #'whitespace-cleanup)

;; interpret ansi color codes - necessary in compilation buffer
(unless (display-graphic-p)
  (ignore-errors
    (require 'ansi-color)
    (defun my-colorize-compilation-buffer ()
      (when (eq major-mode 'compilation-mode)
        (ansi-color-apply-on-region compilation-filter-start (point-max))))
    (add-hook 'compilation-filter-hook 'my-colorize-compilation-buffer)))

;; switch header - cpp
(bind-key* "C-<tab>" 'ff-find-other-file)
;; next 3 lines : alternate method for switching header - cpp from Nico N.
;; (add-hook 'c-mode-common-hook
  ;; (lambda()
    ;; (local-set-key  (kbd "C-c o") 'ff-find-other-file)))

;; CMakeLists mode
(setq load-path (cons (expand-file-name "~/.emacs.d/cmake/") load-path))
(require 'cmake-mode)

;; Bash shell for Windows
(setq explicit-shell-file-name "C:/Devel/Tools/Msys2-64/usr/bin/bash")
(setq explicit-bash-args '("--noediting" "--login" "-i"))
(bind-key* "C-<f1>" 'shell)

;; No confirm kill process: for *shell* and *compilation*
;; https://emacs.stackexchange.com/q/24330
(defun set-no-process-query-on-exit ()
  (let ((proc (get-buffer-process (current-buffer))))
    (when (processp proc)
      (set-process-query-on-exit-flag proc nil))))
(add-hook 'shell-mode-hook 'set-no-process-query-on-exit)

;; Kill the buffer when the shell process exits
;; https://emacs.stackexchange.com/a/48307
(defun kill-buffer-on-shell-logout ()
  (let* ((proc (get-buffer-process (current-buffer)))
         (sentinel (process-sentinel proc)))
    (set-process-sentinel
     proc
     `(lambda (process signal)
        ;; Call the original process sentinel first.
        (funcall #',sentinel process signal)
        ;; Kill the buffer on an exit signal.
        (and (memq (process-status process) '(exit signal))
             (buffer-live-p (process-buffer process))
             (kill-buffer (process-buffer process)))))))
(add-hook 'shell-mode-hook 'kill-buffer-on-shell-logout)

;; Scroll bar
(when (display-graphic-p)
    (scroll-bar-mode -1)
)

;;;;;;;;;;;;;;;;
;; end .emacs ;;
;;;;;;;;;;;;;;;;
