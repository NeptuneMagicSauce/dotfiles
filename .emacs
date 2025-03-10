;; .emacs

;; load minimum settings
(load-file "~/.emacs.d/min-settings.el")

;; customisations global
(setq custom-font-size 140)
(setq custom-accent-color-graphics "#54AFFF") ;; blue
(setq custom-accent-color-terminal "#54AFFF") ;; blue
      ;; "#ff9f00") ;; DarkOrange
;; (setq custom-theme-color "light") ;; dark or light
(setq custom-theme-color "dark") ;; dark or light

;; customisations per machine
(when (string-equal system-name "JOJO2-PC")
  (if (string-equal system-configuration "x86_64-pc-linux-gnu")
      (setq custom-font-size 200)
    (setq custom-font-size 85)))
(when (string-equal system-name "JOJO-PC") (setq custom-font-size 100))
(when (string-equal system-name "JOJO-LAPTOP")
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
(when (string-equal system-name "rlacroix-VirtualBox") (setq custom-font-size 180))
(when (string-equal system-name "vmware-big-computer")
  (setq custom-font-size 120)
  (setq custom-theme-color "dark")
  )
(when (string-equal system-name "potassium") ;; work laptop
  (setq custom-font-size 110)
  (setq custom-theme-color "light")
  )

(defun my-machines ()
  (or
   (string-equal system-name "JOJO-PC")
   (string-equal system-name "JOJO-LAPTOP")
  ))

(defun is-theme-dark ()
  (string-equal custom-theme-color "dark")
  )
(defun is-workplace-23 () ;; is this setup for the workplace started in 2023
  (string-equal system-name "ncelrnd2841")
  )
(when (is-workplace-23) ;; work laptop 2023
  (setq custom-font-size 100)
 (setq custom-theme-color "light")
 ;; (setq custom-theme-color "dark")
 )
(when (not (display-graphic-p))
  ;; in terminal, assume we're in dark mode
  (setq custom-theme-color "dark")
  )

(setq font-size-reset custom-font-size)

(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-completion-style 'helm)
 '(inhibit-startup-screen t)
 '(ispell-dictionary nil)
 '(mouse-buffer-menu-mode-mult 99)
 '(package-selected-packages
   '(all-the-icons bind-key clang-format cmake-mode company doom-themes
                   emojify-logos flycheck helm-lsp helm-xref
                   lsp-treemacs lsp-ui projectile rg which-key)))

;; Show Line Numbers: only for files, not dynamic buffers
;; linum-mode is obsolete, see https://emacs.stackexchange.com/a/280
;; hlinum is not needed with modern line-number-current-line in theme
(add-hook 'find-file-hook 'display-line-numbers-mode)
(setq-default display-line-numbers-width 3)

;; custom script directory
(add-to-list 'load-path "~/.emacs.d/lisp/")

(when (display-graphic-p)
  ;; My preferred FONT
  (custom-set-faces
   (if (and (string-equal system-name "JOJO2-PC")
            (string-equal system-configuration "x86_64-pc-linux-gnu"))
       ;; that's WSL on big computer
       '(default ((t (:family "Monospace Bold" :foundry "outline" :slant normal :weight normal :height 90 :width normal))))
     ;; '(default ((t (:family "DejaVu Sans Mono" :foundry "outline" :slant normal :weight normal :height 90 :width normal))))
     ;; '(default ((t (:family "Lucida Console" :foundry "B&H " :slant normal :weight normal :height 140 :width semi-condensed))))
     ;; Cascadia Mono is more condensed horizontally than Cascadia Code
     '(default ((t (:family "Cascadia Mono" :foundry "SAJA" :slant normal :weight normal :height 102 :width normal))))
     ;; '(default ((t (:family "Cascadia Code" :foundry "SAJA" :slant normal :weight normal :height 102 :width normal))))
     ;; '(default ((t (:family "Menlo" :foundry "outline" :slant normal :weight normal :height 90 :width normal))))
     ;; '(scroll-bar ((t (:background "black" :foreground "black" :width condensed)))) ;; no effect on Windows
  ))
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
    (zoom-text 10))
  (defun zoom-text-decrease ()
    (interactive)
    (zoom-text -10))
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
(setq-default tab-width 2)
(setq-default c-basic-offset 2)
(setq c-default-style "k&r")
(c-set-offset 'inline-open '0)

;; show matching brace / paren
;; https://www.emacswiki.org/emacs/ShowParenMode
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Matching.html
(show-paren-mode 1)
(setq show-paren-when-point-inside-paren 1)

;; custom themes directory
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes") ;; unused

;; auto install packages
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;; (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
;; (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
;; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

;; Mode line setup
(setq-default mode-line-format '(
   ;; %b buffer name
   ;; %m mode name
   ;; https://www.gnu.org/software/emacs/manual/html_node/elisp/_0025_002dConstructs.html

   (:propertize "    %b" face mode-line-filename-face)
   "  "
   (:eval
    (cond
     ;; read-only: custom indicator RO
     (buffer-read-only
      (propertize "RO" 'face 'mode-line-read-only-face))
     ;; modified / unsaved-changes: custom indicator '*'
     ((buffer-modified-p)
      (cond
       ((buffer-file-name)
        (propertize " * " 'face 'mode-line-modified-face))))
     ))
   (vc-mode vc-mode) ;; version-control: branch
   "  " ;; " ("
   (:propertize mode-name face mode-line-mode-face )
   ;; (:propertize " %m " face mode-line-mode-face)
   "  " ;; ") "
   (:propertize mode-line-process)
   ;; line and column numbers: in custom face
   (:propertize " [ %l : %c ] " face mode-line-position-face)
   ;; (:propertize
   ))
(make-face 'mode-line-mode-face)
(make-face 'mode-line-read-only-face)
(make-face 'mode-line-modified-face)
(make-face 'mode-line-filename-face)
(make-face 'mode-line-position-face)
;; filename is bold
(set-face-attribute 'mode-line-filename-face nil
            :inherit 'mode-line-face
            :weight 'bold)
;; line and column numbers: inherit from filename face, and bold
(set-face-attribute 'mode-line-position-face nil
            :inherit 'mode-line-face
            :weight 'bold ;; used to be broken: chars were cut-off/mangled
            )
;; read-only has outline (box) and color
(set-face-attribute 'mode-line-read-only-face nil
            :inherit 'mode-line-face
            :foreground "#4271ae"
            :box '(:line-width 2 :color "#4271ae"))
;; modified / unsaved-changes: black-over-red
(set-face-attribute 'mode-line-modified-face nil
            :inherit 'mode-line-face
            :foreground "Black"
            :background "Red")
;; ;; what do these 4 do?
;; (make-face 'mode-line-folder-face)
;; (make-face 'mode-line-mode-face)
;; (make-face 'mode-line-minor-mode-face)
;; (make-face 'mode-line-process-face)
;; (set-face-attribute 'mode-line-folder-face nil
;;             :inherit 'mode-line-face)
;; (set-face-attribute 'mode-line-mode-face nil
;;             :inherit 'mode-line-face)
;; (set-face-attribute 'mode-line-minor-mode-face nil
;;             :inherit 'mode-line-mode-face)

(defun finish-load-theme ()
  ;; these need to be called after change theme:

  ;; Modeline active-buffe color = accent color
  (set-face-attribute 'mode-line nil :foreground "#111" :background custom-accent-color-graphics)

  ;; Modline inactive-buffer color = grey
  (set-face-attribute 'mode-line-inactive nil :foreground "#FFF" :background "#666")

  ;; Selected-text color = inverted
  (set-face-attribute 'region nil :inverse-video t)

  ;; Apply zoom
  (when (display-graphic-p) (apply-zoom-text))

;;   ;; Company-Mode tooltip colors: no longer needed
;;   (when (display-graphic-p)
;;     (require 'color)
;;     (let ((bg (face-attribute 'default :background)))
;;       (if (is-theme-dark)
;;           (custom-set-faces
;;            `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 10)))))
;;            `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 15)))))
;;            `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
;;            `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
;;            `(company-tooltip-common ((t (:inherit font-lock-constant-face)))))
;;         (custom-set-faces
;;          `(company-tooltip ((t (:inherit default :background ,(color-darken-name bg 20)))))
;;          `(company-scrollbar-bg ((t (:background ,(color-darken-name bg 40)))))
;;          `(company-scrollbar-fg ((t (:background ,(color-darken-name bg 60)))))
;;          '(company-tooltip-selection ((t (:background "#EEE" :foreground "#333"))))
;;          ;; '(company-tooltip-common ((t (:background "#00F" :foreground "#0FF"))))
;;          )
;;         )
;;       )
;;     )
  )

(defun load-chosen-theme()
  ;; (load-theme name t)
  ;; second-argument = t means "no confirm" = load the theme without prompting if safe

  (if (is-theme-dark)
      ;; 0
      (load-theme 'romulus-dark t) ;; mine
      ;; (load-theme 'romulus-dark-old) ;; mine
      ;; (load-theme 'doom-vibrant) ;; nice but comments
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

    ;; LIGHT
    ;; old from 2023.09.06
    ;; (load-theme 'romulus-light t) ;; mine
    ;; (load-theme 'doom-flatwhite)
    ;; (load-theme 'doom-acario-light) ;; company-mode good
    ;; (load-theme 'doom-dracula)
    ;; (load-theme 'doom-gruvbox-light) ;; company-mode good
    ;; (load-theme 'doom-nord-light)
    ;; (load-theme 'doom-one-light)
    ;; (load-theme 'doom-opera-light)
    ;; (load-theme 'doom-plain)
    ;; (load-theme 'doom-solarized-light) ;; company-mode best
    ;; (load-theme 'doom-tomorrow-day) ;; good but company bad

    ;; new in 2025.02.25
    (load-theme 'romulus-bluloco-light t)
    ;; (load-theme 'doom-bluloco-light) ; good
    ;; (load-theme 'doom-oksolar-light) ; good
    ;; (load-theme 'doom-acario-light) ; good
    ;; (load-theme 'doom-one-light) ; good
    ;; (load-theme 'doom-solarized-light) ; good
    ;; (load-theme 'doom-ayu-light) ; bad
    ;; (load-theme 'doom-feather-light) ; bad
    ;; (load-theme 'doom-gruvbox-light) ; bad
    ;; (load-theme 'doom-nord-light) ; bad
    ;; (load-theme 'doom-opera-light) ; bad
    ;; (load-theme 'doom-winter-is-coming-light) ; bad


    )
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
(setq compilation-max-output-line-length nil) ; do not collapse long lines

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
       (if (is-workplace-23)
           "~/workspace/compile.sh"
         (concat
          "make -C " (file-name-directory (buffer-file-name)))))
 (if (and (eq pfx 1)
      compilation-last-buffer)
     (progn
       (set-buffer compilation-last-buffer)
       (revert-buffer t t))
   (call-interactively 'compile))
 )

(setq nproc
      (substring
       (shell-command-to-string "nproc")
       0 -1))
(setenv "MAKEFLAGS" (concat (concat "--no-print-directory -j " nproc)))

;; ;; Zeal dev doc
;; (let ((zeal-dir "c:/Program Files/Zeal"))
;;   (when (file-directory-p zeal-dir)
;;     (add-to-list 'exec-path zeal-dir)
;;     (load-file "~/.emacs.d/zeal-at-point.el")
;;     (bind-key* "C-z" 'zeal-at-point)))

;; add path to Unix programs : make, git
(when (display-graphic-p)
  ;; add path to git and grep for jojo-pc and jojo-laptop
  (when (string-equal system-name "JOJO2-PC")
    (add-to-list 'exec-path "c:/Devel/Tools/Msys2/mingw64/bin") ; ripgrep
    (add-to-list 'exec-path "c:/Devel/Tools/Msys2/usr/bin")     ; git
    )
  ;; jojo-laptop/MinGW ->
  (when (string-equal system-name "JOJO-LAPTOP")
    (add-to-list 'exec-path "c:/Devel/Tools/Msys2/usr/bin"))
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
;; (bind-key* "C-²" 'next-error) ; azerty ; NO, use TAB and C-TAB for cycling through errors
;; (bind-key* "C-`" 'next-error) ; qwerty
;; (bind-key* "M-²" 'previous-error)
;; (bind-key* "M-`" 'previous-error)

;; Auto open error location on compile
;; now working at workplace23 (unless (is-workplace-23)
;; but it jumps for ripgrep matches on windows
;; (setq compilation-auto-jump-to-first-error nil) ; auto-jump to error location on compile
(setq compilation-skip-threshold 2) ; do not auto-jump to warnings

;; Change Buffer
(bind-key* "C-v" 'switch-to-buffer)

;; IDO mode : better switch-to-buffer with choices and arrow support
;; ido breaks helm switch-to-buffer command !
;; (ido-mode 1)
;; (setq ido-enable-flex-matching t) ;; fuzzy helps with typos
;; (setq ido-everywhere nil) ; ido everywhere is not compatible with helm mode

;; Change Window : done in min-settings.el with windmove-default-keybindings

;; Resize Window https://www.emacswiki.org/emacs/WindowResize
(bind-key* "S-C-<left>" 'shrink-window-horizontally)
(bind-key* "S-C-<right>" 'enlarge-window-horizontally)
(bind-key* "S-C-<down>" 'shrink-window)
(bind-key* "S-C-<up>" 'enlarge-window)

;; Comment line
(bind-key* "C-c C-c" 'comment-line)

;; RipGrep for searching
;; https://rgel.readthedocs.io/en/latest/usage.html
(rg-enable-default-bindings)                ;; C-c s
(bind-key* "C-," 'rg-dwim)                  ;; search at point in project
(bind-key* "C-M-," 'rg-dwim-current-file)   ;; search at point in current file
(bind-key* "M-," 'rg-project)               ;; search after asking for input

;; Find File In Project
(bind-key* "C-f" 'project-find-file)

(when (display-graphic-p)

  ;; Change text size with Ctrl and mouse wheel
  (bind-key* "<C-mouse-4>" 'zoom-text-increase)
  (bind-key* "<C-mouse-5>" 'zoom-text-decrease)
  (bind-key* "C-=" 'zoom-text-increase) ; azerty
  (bind-key* "C-+" 'zoom-text-increase) ; qwerty
  (bind-key* "C--" 'zoom-text-decrease)
  ;; (bind-key* "C-à" 'zoom-text-reset)    ; azerty, but this character fails to parse/compile
  (bind-key* "C-0" 'zoom-text-reset)    ; qwerty

  ;; (bind-key* "<mouse-3>" 'mouse-buffer-menu) ; dont bind right-click to buffer-list, it breaks the LSP mouse menu
  ;; mouse-buffer-menu-mode-mult : so that buffer-menu does not have submenus
  (custom-set-variables '(mouse-buffer-menu-mode-mult 99))
  )

;; Switch between light and dark themes
(bind-key* "C-<f12>" (lambda() (interactive) (switch-theme)))
;; needs to be available in terminal mode because it must be changed
;; between dark and light terminals

;; Clean-up whitespace before saving
(add-hook 'before-save-hook #'whitespace-cleanup)

;; interpret ansi color codes - necessary in compilation buffer
;; (unless (display-graphic-p)
  (ignore-errors
    (require 'ansi-color)
    (defun my-colorize-compilation-buffer ()
      (when (eq major-mode 'compilation-mode)
        (ansi-color-apply-on-region compilation-filter-start (point-max))))
    (add-hook 'compilation-filter-hook 'my-colorize-compilation-buffer))

;; switch header - cpp
;; (bind-key* "C-<tab>" 'ff-find-other-file)
;; (setq ff-search-directories '("." "../src" "../include" "../Include" "../C" "../../include"))
; with Projectile: it can find the other file in any directory of the project
(bind-key* "C-<tab>" 'projectile-find-other-file)

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
;; (when (display-graphic-p) (scroll-bar-mode -1))

;; Bell: disable the audible bell (by enabling the visible bell)
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; line-breaks unix, even on windows
;; https://stackoverflow.com/a/21837875
(prefer-coding-system 'utf-8-unix)

;; clang-format
(defun clang-format-save-hook-for-this-buffer ()
  (add-hook 'before-save-hook
            (lambda ()
                (clang-format-buffer)
              ;; Continue to save.
              nil)
            nil
            ;; Buffer local hook.
            t))
(add-hook 'c-mode-hook (lambda () (clang-format-save-hook-for-this-buffer)))
(add-hook 'c++-mode-hook (lambda () (clang-format-save-hook-for-this-buffer)))

;; C++ IDE
(when (not (is-workplace-23))
;; (when (and (display-graphic-p) (not (is-workplace-23)))
;; obsolete: cmake-ide
;; https://github.com/atilaneves/cmake-ide
;; needs this ubuntu package -> rtags and elpa-company
;; company from emacs package-manager fails to show tooltip
;; company from ubuntu package-manager works as intended
  ;; ubuntu packages does not provide "rc" but "rtags-rc"
  ;; (setq rtags-rc-binary-name "/usr/bin/rtags-rc")   ;; does not work
  ;; (setq rtags-rdm-binary-name "/usr/bin/rtags-rdm") ;; does not work
  ;; xor
  ;; (cd /usr/bin; sudo ln -s rtags-rc rc)
  ;; (cd /usr/bin; sudo ln -s rtags-rdm rdm)
  ;; (require 'rtags)
  ;; (cmake-ide-setup) ;; is this needed ?
  ;; (global-company-mode 1)
  ;; (global-company-fuzzy-mode 1) ;; NO not compatible with rtags !
  ;; TODO make company-fuzzy compatible with rtags https://github.com/jcs-elpa/company-fuzzy
  ;; (bind-key* "C-²" 'company-complete)
  ;; ;; (global-flycheck-mode 1) ;; does not work
  ;; (setq company-idle-delay 0)
  ;; (setq cmake-ide-build-dir "build")
  ;; (setq rtags-display-result-backend 'helm)
  ;; (rtags-enable-standard-keybindings)
  ;; ;; default rtags binds:
  ;; ;; C-c r / rtags-find-all-references-at-point
  ;; ;; C-c r . rtags-find-symbol-at-point
  ;; ;; C-c r [ rtags-location-stack-back
  ;; ;; C-c r ] rtags-location-stack-forward
  ;; ;; C-c r , rtags-find-references-at-point
  ;; ;; C-c r G rtags-guess-function-at-point <Find symbol declaration at point>
  ;; (bind-key* "C-o" 'rtags-find-symbol-at-point)
  ;; (bind-key* "M-o" 'rtags-find-all-references-at-point)
  ;; (bind-key* "C-<left>" 'rtags-location-stack-back)
  ;; (bind-key* "C-<right>" 'rtags-location-stack-forward)
  ;; (defun cmake-ide-save-and-compile (nothing)
  ;;   (interactive "p")
  ;;   (save-some-buffers 1)
  ;;   (call-interactively 'cmake-ide-compile)
  ;;   )
 ;; (unless (is-workplace-23)
 ;; this only works for cpp, not for other languages
 ;;   (bind-key* "C-b" 'cmake-ide-save-and-compile)
 ;;   )

  ;; (setq completion-ignore-case t) ;; does not work
  ;; (setq rtags-symbolnames-case-insensitive t) ;; does not work
  ;; (setq rtags-find-file-case-insensitive t) ;; does not work
  ;; (setq company-dabbrev-code-ignore-case t) ;; does not work
  ;; (setq company-dabbrev-ignore-case t) ;; does not work
  ;; C-o does not work on "= new T{}" (also M-o)


  ;; new as of March 2025: LSP and CLANGD

  ;; Fix C-i interpreted as TAB ->
  ;; https://emacs.stackexchange.com/a/17510
  (define-key input-decode-map "\C-i" [C-i])

  (bind-key* "C-o" 'lsp-find-references)   ; Find References
  ;; this one needs <> between key-bind otherwise it gets assigned to TAB !
  (bind-key* "<C-i>" 'lsp-find-definition) ; Go To Definition
  ;; (bind-key* "C-p" 'helm-imenu)         ; Browse Symbols
  (bind-key* "C-p" 'lsp-treemacs-symbols)  ; Browse Symbols
  ;; (bind-key* "C-j" 'lsp-execute-code-action) ; Apply Quick Fix
  (bind-key* "C-j" 'lsp-ui-sideline-apply-code-actions) ; Apply Quick Fix
  (bind-key* "M-p" 'lsp-treemacs-errors-list)


  ;; LSP-UI https://github.com/emacs-lsp/lsp-ui
  (setq lsp-ui-sideline-show-code-actions t)
  (setq lsp-ui-sideline-delay 0.0)

  ;; fix for LSP Treemacs broken on windows:
  ;; https://github.com/emacs-lsp/lsp-treemacs/issues/109#issuecomment-1114766364
  (defun lsp-f-ancestor-of-patch (path-args)
    (mapcar (lambda (path) (downcase path)) path-args))
  (when (eq system-type 'windows-nt)
    (advice-add 'lsp-f-ancestor-of? :filter-args #'lsp-f-ancestor-of-patch)
    (advice-add 'lsp-f-same? :filter-args #'lsp-f-ancestor-of-patch))

  )

;; from https://emacs-lsp.github.io/lsp-mode/tutorials/CPP-guide/
;; sample `helm' configuration use https://github.com/emacs-helm/helm/ for details
(helm-mode)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)
(which-key-mode)
(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-minimum-prefix-length 1)

;; (bind-key* "C-o" 'xref-find-references)     ; Find All References
;; (bind-key* "C-p" 'helm-imenu)               ; Browse Symbols
;; (bind-key* "C-j" 'lsp-treemacs-errors-list) ; Show Error List
;; (bind-key* "<tab>" 'indent-region) ; not needed with fix C-i as TAB

;; Treemacs error list: auto expand is enabled like this:
;; https://github.com/emacs-lsp/lsp-treemacs/pull/148
;; remove .emacs.d/elpa/lsp-treemacs-20230811.611/lsp-treemacs.elc
;; patch .emacs.d/elpa/lsp-treemacs-20230811.611/lsp-treemacs.el
;; @@ -1022,7 +1022,7 @@ With prefix 2 show both."
;;            (lsp-session-folders)
;;            (-keep #'lsp-treemacs--build-error-list)))
;;     "Errors List"
;; -   nil
;; +   10
;;     lsp-treemacs-errors-buffer-name
;;     `(["Cycle Severity" lsp-treemacs-cycle-severity])))

;; (when (display-graphic-p)
;;   (bind-key* "C-²" 'company-complete) ; azerty
;;   (bind-key* "C-`" 'company-complete) ; qwerty
;;   ;; in terminal mode this keypress generates C-@
;;   ;; which is the same as C-space
;;   ;; -> broken in terminal
;;   ;; -> disabled in terminal
;;   )

(add-hook 'c-mode-hook #'lsp-deferred)
(add-hook 'c++-mode-hook #'lsp-deferred)

(global-company-mode 1)
(setq company-idle-delay 0.0)
(setq lsp-idle-delay 0.0)
(setq flycheck-idle-change-delay 3.0) ;; that's the delay before inline errors and fixits are shown

(setq lsp-keymap-prefix "C-d") ; must be before load lsp: before eval-after-load lsp ...

(with-eval-after-load 'lsp-mode

  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  ;; (require 'dap-cpptools) ; we are not using dap (the debugger integration)

  ;; YAS = YASnippet = unused, see https://github.com/joaotavora/yasnippet
  ;; (yas-global-mode)

  (setq lsp-headerline-breadcrumb-enable nil) ; disable breadcrumb / headerline

  (when (is-workplace-23)
    (setq lsp-log-io nil lsp-file-watch-threshold 3000) ;; limit the number of files to be watched
    (setq company-dabbrev-downcase 0)
    ;; (setq lsp-idle-delay 0.1)
    (setq lsp-enable-file-watchers nil)
    (setq lsp-clients-clangd-args '("--compile-commands-dir=." ;; help clang find the CDB
                                    "--header-insertion-decorators=0"
                                    "--header-insertion=never" ;; Unfortunately our code sucks, the include order may be important and clangd does not know that
                                    "--log=verbose"
                                    "--query-driver=/usr/bin/g++" ;; help clangd find the right g++ driver to find libstdc++'s headers
                                    "--pch-storage=memory" ;; If the pch are saved on disk they may fill up /tmp
                                    "--cross-file-rename"
                                    "--background-index"
                                    "--limit-results=100000"
                                    "-j=4")) ;; Don't take up too much resources
    (setq lsp-disabled-clients '(ccls))
    )
  )

;;;;;;;;;;;;;;;;
;; end .emacs ;;
;;;;;;;;;;;;;;;;
