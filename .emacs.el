;; .emacs

;; load minimum settings
(load-file "~/.emacs.d/min-settings.el")

;; customisations global
(setq custom-font-size 140)
(setq custom-accent-color "#54AFFF") ;; blue
(setq inactive-modeline-color "#666")
(setq custom-accent-color-darker "#007EEE") ;; (color-darken-name custom-accent-color 30)
;; "#ff9f00") ;; DarkOrange

;; (setq custom-theme-color "light") ;; dark or light
(setq custom-theme-color "dark") ;; dark or light

;; customisations per machine
(when (string-equal system-name "JOJO2-PC")
  (if (string-equal system-configuration "x86_64-pc-linux-gnu")
      ;; must be WSL
      ;; see ~/.windows_settings/wsl/.wslgconfig for dpi-scaling-bluriness
      (setq custom-font-size 270)
    (setq custom-font-size 85)))
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

;; (defun my-machines ()
;;   (or
;;    (string-equal system-name "JOJO-PC")
;;    (string-equal system-name "JOJO-LAPTOP")
;;   ))

(defun is-theme-dark ()
  (string-equal custom-theme-color "dark")
  )
(defun is-workplace-23 () ;; is this setup for the workplace started in 2023
  (string-equal system-name "ncelrnd2841")
  )
(when (is-workplace-23) ;; work laptop 2023
  ;; (setq custom-font-size 200) ;; 4K screen
  (setq custom-font-size 150) ;; 1440p screen
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
 '(warning-suppress-types '((comp)))
 '(package-selected-packages
   '(all-the-icons bind-key clang-format cmake-mode company diff-hl
                   doom-themes emojify-logos flycheck helm-lsp
                   helm-xref lsp-pyright lsp-treemacs lsp-ui pkg-info
                   projectile rg which-key)))

;; byte-compile all the packages
(byte-recompile-directory (expand-file-name "~/.emacs.d/elpa") 0)

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
   '(default ((t (:family "Cascadia Code" :slant normal :weight semilight :height 90 :width normal)))
;; '(default ((t (:family "DejaVu Sans Mono" :slant normal :weight normal :height 90 :width normal)))
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

;; (defvar my-compilation-spinner-frames '("⡇" "⠏" "⠛" "⠹" "⢸" "⣰" "⣤" "⣆" )) ;; with 3 dots
(defvar my-compilation-spinner-frames '("⠇" "⠋" "⠙" "⠸" "⢰" "⣠" "⣄" "⡆")) ;; with 4 dots
(defvar my-compilation-spinner-index 0)
(defvar my-compilation-spinner-timer nil)

(defun my-compilation-spinner-advance ()
  "Advance the spinner and update modeline."
  (setq my-compilation-spinner-index
        (mod (1+ my-compilation-spinner-index)
             (length my-compilation-spinner-frames)))
  (force-mode-line-update t))

(defun my-compilation-spinner-start  (&rest _)
  "Start the spinner timer."
  (unless my-compilation-spinner-timer
    (setq my-compilation-spinner-timer
          (run-with-timer 0 0.10 #'my-compilation-spinner-advance))))

(defun my-compilation-spinner-stop (&rest _)
  "Stop the spinner timer."
  (when my-compilation-spinner-timer
    (cancel-timer my-compilation-spinner-timer)
    (setq my-compilation-spinner-timer nil)))

(add-hook 'compilation-start-hook #'my-compilation-spinner-start)
(add-hook 'compilation-finish-functions #'my-compilation-spinner-stop)

;; Mode line setup
(setq-default mode-line-format '(
                                 ;; %b buffer name
                                 ;; %m mode name
                                 ;; https://www.gnu.org/software/emacs/manual/html_node/elisp/_0025_002dConstructs.html

                                 ;; file name
                                 (:propertize "    %b " face mode-line-filename-face)

                                 ;; revert notification
                                 (:eval my/revert-notification)

                                 ;; buffer properties: Unsaved or Read-Only
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

                                 ;; position: line, column, %age in custom face
                                 (:propertize " [%p L%l:%c] " face mode-line-position-face)

                                 ;; LSP
                                 ;; (:eval (when (bound-and-fn 'lsp-mode) lsp-modeline-workspace-status)) ;; not actually needed
                                 " " mode-line-misc-info ;; this is needed for clangd indexing progress
                                 ;; mode-line-modes ;; ??
                                 ;; mode-line-end-spaces ;; ??

                                 ;; version-control: branch
                                 (vc-mode vc-mode)

                                 ;; major mode, except for compilation buffer
                                 (:eval
                                  (unless (derived-mode-p 'compilation-mode)
                                    (concat " " (propertize (format-mode-line mode-name) 'face 'mode-line-mode-face))))


                                 ;; compilation status
                                 (:eval
                                  (when (derived-mode-p 'compilation-mode)
                                    (let ((proc (get-buffer-process (current-buffer)))
                                          (errors (if (boundp 'compilation-num-errors-found)
                                                      compilation-num-errors-found 0))
                                          (warnings (if (boundp 'compilation-num-warnings-found)
                                                        compilation-num-warnings-found 0)))
                                      (cl-flet ((pluralize (n singular)
                                                  (format "%d %s" n (if (= n 1) singular (concat singular "s")))))
                                        (cond
                                         (proc
                                          (propertize (format "[%s %s]"
                                                              (if (= 0 (mod (/ my-compilation-spinner-index 5) 2)) "🔥" "💨")
                                                              (nth my-compilation-spinner-index
                                                                   my-compilation-spinner-frames))
                                                      'face (if (mode-line-window-selected-p)
                                                                'compilation-mode-line-run-active
                                                              'compilation-mode-line-run-inactive)))

                                         ((> errors 0)
                                          (concat
                                           (propertize (format "[✘ %s" (pluralize errors "Error"))
                                                       'face (if (mode-line-window-selected-p)
                                                                 'compilation-mode-line-fail-active
                                                               'compilation-mode-line-fail-inactive))
                                           (if (> warnings 0)
                                               (propertize (format ", %s]" (pluralize warnings "Warning"))
                                                           'face (if (mode-line-window-selected-p)
                                                                     'compilation-mode-line-warning-active
                                                                   'compilation-mode-line-warning-inactive))
                                             (propertize "]" 'face (if (mode-line-window-selected-p)
                                                                        'compilation-mode-line-fail-active
                                                                      'compilation-mode-line-fail-inactive)))))
                                         ((> warnings 0)
                                          (propertize (format "[✨ OK, %s]" (pluralize warnings "Warning"))
                                                      'face (if (mode-line-window-selected-p)
                                                                'compilation-mode-line-warning-active
                                                              'compilation-mode-line-warning-inactive)))
                                         ((local-variable-p 'compilation-directory)
                                          (propertize "[✨ OK]" 'face (if (mode-line-window-selected-p)
                                                                            'compilation-mode-line-exit-active
                                                                      'compilation-mode-line-exit-inactive))))))))
                                 ))

(make-face 'compilation-mode-line-warning-active)
(make-face 'compilation-mode-line-warning-inactive)
(make-face 'compilation-mode-line-fail-active)
(make-face 'compilation-mode-line-fail-inactive)
(make-face 'compilation-mode-line-exit-active)
(make-face 'compilation-mode-line-exit-inactive)
(make-face 'compilation-mode-line-run-active)
(make-face 'compilation-mode-line-run-inactive)

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
  (set-face-attribute 'mode-line nil :foreground "#111" :background custom-accent-color)

  ;; Modline inactive-buffer color = grey
  (set-face-attribute 'mode-line-inactive nil :foreground "#FFF" :background inactive-modeline-color)

  (setq compilation-activate-background "#444")
  ;; Compilation Running
  (set-face-attribute 'compilation-mode-line-run-active nil :foreground "orange" :weight 'bold)
  (set-face-attribute 'compilation-mode-line-run-inactive nil :foreground "orange" :weight 'bold)
  ;; Compilation Warning
  (set-face-attribute 'compilation-mode-line-warning-active nil :foreground "#f5b949" :background compilation-activate-background :weight 'bold)
  (set-face-attribute 'compilation-mode-line-warning-inactive nil :foreground "#f5b949" :background compilation-activate-background :weight 'bold)
  ;; Compilation Error
  (set-face-attribute 'compilation-mode-line-fail-active nil :foreground "#f27f6f" :background compilation-activate-background :weight 'bold)
  (set-face-attribute 'compilation-mode-line-fail-inactive nil :foreground "#f27f6f" :background compilation-activate-background :weight 'bold)
  ;; Compilation OK
  (set-face-attribute 'compilation-mode-line-exit-active nil :foreground "#8bf081" :weight 'bold)
  (set-face-attribute 'compilation-mode-line-exit-inactive nil :foreground "#8bf081" :weight 'bold)

  ;; Selected-text color = inverted
  (set-face-attribute 'region nil :inverse-video t)

  ;; Apply zoom
  (when (display-graphic-p) (apply-zoom-text))

  ;; Company-Mode tooltip colors:
  (when (display-graphic-p)
    (require 'color)
    (let ((bg (face-attribute 'default :background)))
      (if (is-theme-dark)
          (custom-set-faces
           `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 10)))))
           `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 15)))))
           `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
           `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
           `(company-tooltip-common ((t (:inherit font-lock-constant-face)))))
        (custom-set-faces
         `(company-tooltip ((t (:inherit default :background ,(color-darken-name bg 20)))))
         `(company-scrollbar-bg ((t (:background ,(color-darken-name bg 40)))))
         `(company-scrollbar-fg ((t (:background ,(color-darken-name bg 60)))))
         '(company-tooltip-selection ((t (:background "#EEE" :foreground "#333"))))
         ;; '(company-tooltip-common ((t (:background "#00F" :foreground "#0FF"))))
         )
        )
      )
    )
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
    (load-theme 'romulus-light t)
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

;; Compilation output: auto scrolling
;; (setq compilation-scroll-output t)
(setq compilation-scroll-output 'first-error) ;; auto scroll compile buffer to first error
(setq compilation-max-output-line-length nil) ;; do not collapse long lines



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

;; ;; Zeal dev doc
;; (let ((zeal-dir "c:/Program Files/Zeal"))
;;   (when (file-directory-p zeal-dir)
;;     (add-to-list 'exec-path zeal-dir)
;;     (load-file "~/.emacs.d/zeal-at-point.el")
;;     (bind-key* "C-z" 'zeal-at-point)))

;; add path to Unix programs : make, git
(when (display-graphic-p)
  (when (eq system-type 'windows-nt)
    ;; add path to git and grep for jojo-pc and jojo-laptop
    (when (string-equal system-name "JOJO2-PC")
      (add-to-list 'exec-path "c:/Devel/Tools/Msys2/mingw64/bin") ; ripgrep
      (add-to-list 'exec-path "c:/Devel/Tools/Msys2/usr/bin")     ; git
      )
    ;; jojo-laptop/MinGW ->
    (when (string-equal system-name "JOJO-LAPTOP")
      (add-to-list 'exec-path "c:/Devel/Tools/Msys2/usr/bin"))
    )
  )

;; Reload config
(defun reload-config ()
  (interactive)
  (load-file "~/.emacs.el"))

;; Number of Processors
(setq nproc
      (substring
       (shell-command-to-string "nproc")
       0 -1))
(setenv "MAKEFLAGS" (concat (concat "--no-print-directory -j " nproc)))

;; Compile and ReCompile : https://www.emacswiki.org/emacs/CompileCommand#toc4
(defun compile-dwim (pfx)
  """
Compile-Do-What-I-Mean
runs the compilation without asking
either ninja in dominating directory
or the workspace script
"""
  (interactive "p")
  (save-some-buffers 1)
  ;; default compile command : enable parallelism, default to dir of current buffer
  ;; set it on first invocation of compile command, not at startup because no buffer
  (setq compile-command
        (if (is-workplace-23)
            "~/workspace/compile.sh"
          (concat
           "ninja -C " (locate-dominating-file buffer-file-name "build.ninja"))))
  (if (and (eq pfx 1)
           compilation-last-buffer)
      (progn
        (set-buffer "*compilation*")
        (revert-buffer t t))
    (call-interactively 'compile))
  )
(setq compilation-read-command nil) ;; do not prompt for compile command

;; (setq compilation-last-buffer nil) ;; why !?

;; Auto open error location on compile:
;; problem: it jumps to ripgrep first result!
;; (setq compilation-auto-jump-to-first-error t) ; auto-jump to error location on compile
;; (setq compilation-auto-jump-to-first-error nil) ; (default value) do not auto-jump to error
(setq compilation-skip-threshold 2) ; do not scroll and auto-jump to warnings

(defun compile-again (pfx)
  (interactive "p")
  (setq compilation-read-command t)
  (call-interactively 'compile)
  )

;; Visit RipGrep buffer when it finishes
;; https://github.com/Jousimies/.emacs.d/blob/master/lisp/init-search.el#L36
(with-eval-after-load 'rg
  (add-to-list 'rg-finish-functions
               (lambda (buffer _)
                 (pop-to-buffer buffer)
                 )))

;; KEY BINDINGS

;; Compile
(bind-key* "C-b" 'compile-dwim)
(bind-key* "C-S-b" 'compile-again)

;; Reload Config
(bind-key* "C-S-r" 'reload-config)

;; Undo
(bind-key* "C-u" 'undo)

;; Scrolling : Ctrl-up/down scroll 1 line
(bind-key* "C-<down>" 'scroll-up-line)
(bind-key* "C-<up>" 'scroll-down-line)
;; Binding GOTO-LINE
(bind-key* "M-g" 'goto-line)

;; Previous / Next buffer
(bind-key* "M-<left>" 'previous-buffer)
(bind-key* "M-<right>" 'next-buffer)

;; Next Error
;; (bind-key* "C-²" 'next-error) ; azerty ; NO, use TAB and C-TAB for cycling through errors
;; (bind-key* "C-`" 'next-error) ; qwerty
;; (bind-key* "M-²" 'previous-error)
;; (bind-key* "M-`" 'previous-error))

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
                                        ; load the local config which does "include hidden"
(setq-default rg-ignore-ripgreprc nil)
(setenv "RIPGREP_CONFIG_PATH" (expand-file-name ".ripgreprc" (getenv "HOME")))

;; FlyCheck
(bind-key* "C-q C-q" 'flycheck-next-error) ;; go to next compile error in buffer
(bind-key* "C-q C-r" 'flycheck-previous-error) ;; go to previous compile error in buffer

;; Action At Point: search or select, word or line
(bind-key* "C-q C-s" 'isearch-forward-symbol-at-point)
;; https://irfu.cea.fr/Pisp/frederic.galliano/Computing/manual_elisp.html
(defun select-current-word ()
  (interactive)
  (let (pt)
    (skip-chars-backward "-_A-Za-z0-9./")
    (setq pt (point))
    (skip-chars-forward "-_A-Za-z0-9./")
    (set-mark pt)))
(defun select-current-line ()
  (interactive)
  (let ((pos (line-beginning-position)))
    (end-of-line)
    (set-mark pos)))
(bind-key* "C-M-SPC" 'select-current-word)
(bind-key* "C-M-<return>" 'select-current-line)

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
;; also have a binding that works in Terminal which catches Ctrl-Tab :
(bind-key* "M-`" 'projectile-find-other-file)

;; Bash shell for Windows
(when (eq system-type 'windows-nt)
  (setq explicit-shell-file-name "C:/Devel/Tools/Msys2-64/usr/bin/bash")
  (setq explicit-bash-args '("--noediting" "--login" "-i"))
  )
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

;; Auto-Revert files that changed on disk
(global-auto-revert-mode 1)
;; Also auto-revert dired buffers
(setq global-auto-revert-non-file-buffers t)

;; Auto-Revert conflict resolution: when there are unsaved changes, prompt
(defun my/check-modified-buffer-changed ()
  "Prompt user when a modified buffer's file changes on disk."
  (when (and buffer-file-name
             (buffer-modified-p)
             (not (verify-visited-file-modtime (current-buffer))))
    (clear-visited-file-modtime)
    (if (y-or-n-p ;; yes-or-no-p ;; must type the whole 'yes' with yes-or-no-p
         (format "'%s' changed on disk.  Discard changes and reload? "
                 (file-name-nondirectory buffer-file-name)))
        (progn
          (let ((inhibit-message t))
            (revert-buffer t t))
          (my/notify-buffer-reverted (file-name-nondirectory buffer-file-name)))
          ;; (message "Reloaded from disk. "))
      (clear-visited-file-modtime)
      (message "Kept buffer version. Use M-x revert-buffer to reload later."))))
(setq use-dialog-box nil) ;; prompt in the minibuffer, no GUI widget/box

;; Auto-Revert: feedback message in the modeline
(defvar-local my/revert-notification nil
  "Current revert notification text for this buffer.")
(defvar-local my/revert-notification-timer nil
  "Timer for clearing revert notification.")
(defun my/revert-animation-advance (buffer)
  "Advance the revert animation in BUFFER."
  (when (buffer-live-p buffer)
    (with-current-buffer buffer
      (setq my/revert-animation-index
            (mod (1+ my/revert-animation-index)
                 (length my/revert-animation-frames)))
      (setq my/revert-notification
            (propertize (nth my/revert-animation-index my/revert-animation-frames)
                        'face 'my/revert-notify-face))
      (force-mode-line-update))))
(defun my/clear-revert-notification-in-buffer (buffer)
  "Clear the revert notification from modeline in BUFFER."
  (when (buffer-live-p buffer)
    (with-current-buffer buffer
      (when my/revert-notification-timer
        (cancel-timer my/revert-notification-timer)
        (setq my/revert-notification-timer nil))
      (when my/revert-animation-timer
        (cancel-timer my/revert-animation-timer)
        (setq my/revert-animation-timer nil))
      (setq my/revert-notification nil)
      (force-mode-line-update))))
(defvar-local my/revert-animation-timer nil
  "Timer for animating revert notification.")
(defvar-local my/revert-animation-index 0
  "Current frame index for animation.")
(defvar my/revert-animation-frames
  '(
    " 🔀 "
    " 🔁 "
    ;; " 🔄 🔃 "
    ))
(defface my/revert-notify-face
  '((t :foreground "#ffffff"
       :background "#4a90d9"
       :weight bold))
  "Face for buffer revert notifications.")

;; Auto-Revert feedback message : modified buffers
(defun my/notify-buffer-reverted (buffer-name)
  "Show animated notification that BUFFER-NAME was reverted."
  ;; (my/clear-revert-notification)
  (let ((buffer (current-buffer)))
    (my/clear-revert-notification-in-buffer buffer)
    (setq my/revert-animation-index 0)
    (setq my/revert-notification
          (propertize (nth 0 my/revert-animation-frames)
                      'face 'my/revert-notify-face))
    (force-mode-line-update)
    ;; Start animation timer
    (setq my/revert-animation-timer
          (run-at-time 0.1 0.3 #'my/revert-animation-advance buffer))
    ;; Stop after duration
    (setq my/revert-notification-timer
          (run-at-time 4.0 nil #'my/clear-revert-notification-in-buffer buffer))))

;; Auto-Revert feedback message : unmodified buffers
(defun my/notify-auto-reverted ()
  "Show notification when a buffer is auto-reverted."
  (my/notify-buffer-reverted (file-name-nondirectory buffer-file-name)))
(add-hook 'after-revert-hook #'my/notify-auto-reverted)
(setq auto-revert-verbose nil)

;; Auto-Revert: also check in all buffers when Emacs gains focus
(defun my/check-all-buffers-for-changes ()
  "Check all file buffers for external modifications."
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (my/check-modified-buffer-changed))))
(add-hook 'focus-in-hook #'my/check-all-buffers-for-changes)

;;; end Auto-Revert


;; Don't display *Compile-Log* buffer
(add-to-list 'display-buffer-alist
             '("\\*Compile-Log\\*"
               (display-buffer-no-window)
               (allow-no-window . t)))

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
(add-hook 'c++-mode-hook (lambda () (setq require-final-newline t)))

;; hs-minor-mode enables code block folding
(add-hook 'cmode-hook #'hs-minor-mode)
(add-hook 'c++-mode-hook #'hs-minor-mode)
(bind-key* "C-c -" 'hs-hide-block)
(bind-key* "C-c +" 'hs-show-block)

;; version-control/git changed lines in the fringe
(global-diff-hl-mode t)

;; C++ IDE
(if () ;;(when (not (is-workplace-23))
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
    ;; needed to use C-i as a key-bind
    ;; https://emacs.stackexchange.com/a/17510
    ;; needs next 2 lines to enable bind-key C-i
    ;; (define-key input-decode-map "\C-i" [C-i])
    ;; (bind-key* "<tab>" 'indent-region)
    ;; but it breaks "tab goes to next error in compile buffer" -> disable

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
;; Adjust the helm buffer width
(setq helm-buffer-max-length 42)  ; Increase the number to make filename column wider

(which-key-mode)
(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-minimum-prefix-length 1)

;; (bind-key* "<tab>" 'indent-region) ; not needed with fix C-i as TAB ;; old comment

;; Treemacs error list: auto expand is enabled like this:
(setq lsp-treemacs-error-list-expand-depth t) ;; this works to expand depth 1, fails to further expand below
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

;; choose the clangd version
(when (is-workplace-23)
  (custom-set-variables
   '(lsp-clients-clangd-executable
     "~/workspace/buildserver/ssp_docker_run"
     )))
(unless (is-workplace-23)
  (custom-set-variables
   '(lsp-clangd-binary-path "/usr/bin/clangd")))

(add-hook 'c-mode-hook #'lsp-deferred)
(add-hook 'c++-mode-hook #'lsp-deferred)
(add-hook 'python-mode-hook #'lsp-deferred)

(global-company-mode 1)
(setq company-idle-delay 0.0)
(setq lsp-idle-delay 0.0)
(setq lsp-ui-doc-delay 2.0) ;; that's the delay for the pop-ups "doc" = when hovering a function or variable
;; flycheck provides inline error, error highlight, and go to next error
(setq flycheck-idle-change-delay 3.0) ;; that's the delay before inline errors and fixits are shown
;; (add-hook 'after-init-hook #'global-flycheck-mode) ;; not needed !

(setq lsp-keymap-prefix "C-d") ; must be before load lsp: before eval-after-load lsp ...

;; EDIFACT syntax highlighting
(define-generic-mode
    'edi-mode
  '("'")
  '("")
  '(
    ("\\\\."  . 'font-lock-function-name-face)
    ("^[[:upper:]]\\{3\\}" . font-lock-type-face)
    ("\+" . 'font-lock-builtin-face)
    ("\*" . 'font-lock-preprocessor-face)
    (":" . 'font-lock-keyword-face)

    ("\\([0-9]*[A-Z?][0-9A-Z?]*\\)\\(\+\\|:\\|\*\\|'\\)"  (1 'font-lock-string-face))
    ("\\([0-9]+\\)\\(\+\\|:\\|\*\\|'\\)"  (1 'font-lock-constant-face)))
  '("\\.edi$")
  nil
  "Mode for edifact files"
  )

(with-eval-after-load 'lsp-mode

  ;; bind-key for LSP must be done here, not earlier
  ;; otherwise it's broken: C-o = 'insert-line' and C-i = 'TAB'
  ;; also: if we bind C-i to lsp-find-def, then it breaks TAB -> next-compile-error
  (bind-key* "C-o" 'lsp-find-definition)   ; Go To Definition
  (bind-key* "M-o" 'lsp-find-references)   ; Find References
  (bind-key* "M-p" 'helm-imenu)         ; Browse Symbols Helm
  ;; (bind-key* "C-p" 'lsp-treemacs-symbols)  ; Browse Symbols Treemacs
  (bind-key* "C-p" 'helm-lsp-diagnostics) ; Error list with helm: works the best
  (bind-key* "C-q p" 'lsp-ui-flycheck-list) ; Error list with flycheck: works great, go to error with M-<ENTER>
  ;; (bind-key* "M-p" 'lsp-treemacs-errors-list) ; Error list with treemacs: buggy, does not expand

  ;; (bind-key* "C-j" 'lsp-execute-code-action) ; Apply Quick Fix ; better with next line
  ;; (bind-key* "C-j" 'lsp-ui-sideline-apply-code-actions) ; Apply Quick Fix
  (bind-key* "C-j" 'helm-lsp-code-actions) ; Apply Quick Fix

  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  ;; (require 'dap-cpptools) ; we are not using dap (the debugger integration)

  (setq lsp-enable-snippet nil) ;; otherwise it prints a warning

  (setq lsp-headerline-breadcrumb-enable nil) ; disable breadcrumb / headerline

  (setq lsp-clients-clangd-args '("--log=verbose" ;; more concise than verbose
                                  "--background-index"
                                  "--background-index-priority=normal" ;; normal or low or background
                                  "--header-insertion=never"
                                  "--pch-storage=memory"))

  ;; limit the number of threads on small machines
  (if (<= (string-to-number nproc) 4)
      (push "-j=2" lsp-clients-clangd-args))

  (message "Process Count %s" nproc)
  (message "Clangd Args %s" lsp-clients-clangd-args)

  (when (is-workplace-23)
    (setq lsp-log-io nil lsp-file-watch-threshold 3000) ;; limit the number of files to be watched
    (setq company-dabbrev-downcase 0)
    ;; (setq lsp-idle-delay 0.1)
    (setq lsp-enable-file-watchers nil)
    ;; clangd args
    ;; merged from Confluence page 'Emacs' and project/.vscode/examples/settings.json.default:
    (setq lsp-clients-clangd-args '("/tools/llvm/current/bin/clangd"
                                    "--log=verbose"
                                    "--background-index"
                                    "--background-index-priority=normal" ;; normal or low or background
                                    "--header-insertion=never"
                                    "--pch-storage=memory"
                                    "--enable-config"
                                    ;; "-j=20"
                                    "-j=6"
                                    "--limit-results=100000"
                                    ))

    ;; clangd crashes often with -j=14
    (setq lsp-disabled-clients '(ccls))
    )
  )

;;;;;;;;;;;;;;;;
;; end .emacs ;;
;;;;;;;;;;;;;;;;
