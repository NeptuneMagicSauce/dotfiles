;;; romulus-dark-theme.el --- a more vibrant variant of doom-one -*- lexical-binding: t; no-byte-compile: t; -*-

;; option no-byte-compile t on first line is important
;; otherwise we fail the compile with Error: Bytecode overflow

(require 'doom-themes)

(defgroup doom-vibrant-theme nil
  "Options for the `doom-vibrant' theme."
  :group 'doom-themes)

(def-doom-theme romulus-dark
  "A dark theme based off of doom-one with more vibrant colors."

  ;; name        gui       256           16
  (
   (bg         '("#2D2D2D" "black" "black"            ))
   (fg         '("#bbc2cf" "#bfbfbf"     "#FFF" ))
   ;; These are off-color variants of bg/fg, used primarily for `solaire-mode',
   ;; but can also be useful as a basis for subtle highlights (e.g. for hl-line
   ;; or region), especially when paired with the `doom-darken', `doom-lighten',
   ;; and `doom-blend' helper functions.
   (bg-alt     '("#2a2e38" "black"       "black"       ))
   (fg-alt     '("#5D656B" "#5d5d5d"     "white"       ))

   ;; These should represent a spectrum from bg to fg, where base0 is a starker
   ;; bg and base8 is a starker fg. For example, if bg is light grey and fg is
   ;; dark grey, base0 should be white and base8 should be black.
   (base0      '("#1c1f24" "#101010"     "black"       ))
   (base1      '("#1c1f24" "#1e1e1e"     "#000" ))
   (base2      '("#21272d" "#21212d"     "#000" ))
   (base3      '("#23272e" "#262626"     "#000" ))
   (base4      '("#484854" "#5e5e5e"     "#000" ))
   (base5      '("#62686E" "#666666"     "#000" ))
   (base6      '("#757B80" "#7b7b7b"     "#000" ))
   (base7      '("#9ca0a4" "#979797"     "#000" ))
   (base8      '("#DFDFDF" "#dfdfdf"     "white"       ))

   (grey       base4)
   (red        '("#ff665c" "#ff6655" "red"             ))
   (orange     '("#e69055" "#dd8844" "#dd8844"       ))
   (green      '("#7bc275" "#99bb66" "green"           ))
   (teal       '("#4db5bd" "#44b9b1" "#44b9b1"     ))
   (yellow     '("#FCCE7B" "#ECBE7B" "yellow"          ))
   (blue       '("#51afef" "#51afef" "#51afef"      ))
   (dark-blue  '("#1f5582" "#2257A0" "blue"            ))
   (magenta    '("#C57BDB" "#c678dd" "#c678dd"   ))
   (violet     '("#a991f1" "#a9a1e1" "magenta"         )) ;a9a1e1
   (cyan       '("#5cEfFF" "#46D9FF" "#46D9FF"      ))
   (dark-cyan  '("#6A8FBF" "#5699AF" "cyan"            ))

   ;; These are the "universal syntax classes" that doom-themes establishes.
   ;; These *must* be included in every doom themes, or your theme will throw an
   ;; error, as they are used in the base theme defined in doom-themes-base.
   ; highlight is "search match background, but the value set here is then brightened"
   (highlight      red);"#777");"#888")
   ;; region is "selected text foreground"
   (region         "#000");"#444");"#3d4451")
   (selection      dark-blue)
   (vertical-bar   base0)

   (builtin        magenta)
   (comments       blue);"#666")
   (doc-comments   comments)
   (constants      violet)
   (functions      cyan)
   (keywords       blue)
   (methods        violet)
   (operators      magenta)
   (type           yellow)
   (strings        green)
   (variables      (doom-lighten magenta 0.4))
   (numbers        orange)
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    yellow)
   (vc-added       green)
   (vc-deleted     red)

   ;; ;; These are extra color variables used only in this theme; i.e. they aren't
   ;; ;; mandatory for derived themes.
   ;; (modeline-fg             fg)
   ;; (modeline-fg-inactive    (doom-blend blue grey (if doom-vibrant-brighter-modeline 0.9 0.2)))
   ;; (modeline-bg             (if doom-vibrant-brighter-modeline
   ;;                              `("#383f58" ,@(cdr base1))
   ;;                            `(,(doom-darken (car bg) 0.15) ,@(cdr base1))))
   ;; (modeline-bg-alt         (if doom-vibrant-brighter-modeline
   ;;                              modeline-bg
   ;;                            `(,(car bg-alt) ,@(cdr base0))))
   ;; (modeline-bg-inactive     `(,(doom-darken (car bg-alt) 0.2) ,@(cdr base0)))
   ;; (modeline-bg-alt-inactive (doom-darken bg 0.25))
   ;; ;((lazy-highlight &override) :background "#0000d7" :foreground "#dfdfdf")
   ;; (-modeline-pad
   ;;  (when doom-vibrant-padded-modeline
   ;;    (if (integerp doom-vibrant-padded-modeline) doom-vibrant-padded-modeline 4)))
   )


  ;;;; Base theme face overrides
  (
   ;; ((font-lock-comment-face &override)
   ;;  :background (if doom-vibrant-brighter-comments (doom-darken bg-alt 0.095)))

   ; my customisations for line-number and line-number-current-line
   (line-number :background "#222" :foreground "#999")
   (line-number-current-line :inverse-video t :bold bold)
   ;; ;; (line-number-current-line :background "#999" :foreground "#222" :bold bold)

   ;; lsp-ui
   ;; fix-it suggestions in sideline:
   (lsp-ui-sideline-global :box nil :inverse-video t)

   ;; (lazy-highlight :background "#54afff" :foreground "#000000" :bold bold)
   ;; (lsp-face-highlight-textual :background "#375467" :foreground "#DFDFDF")

   ;; (mode-line
   ;;  :background modeline-bg :foreground modeline-fg
   ;;  :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   ;; (mode-line-inactive
   ;;  :background modeline-bg-inactive :foreground modeline-fg-inactive
   ;;  :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   ;; (mode-line-emphasis :foreground (if doom-vibrant-brighter-modeline base8 highlight))
   ;; (org-block :background (doom-darken base3 0.1))

   ;; ;;;; all-the-icons
   ;; ((all-the-icons-dblue &override) :foreground dark-cyan)
   ;; ;;;; centaur-tabs
   ;; (centaur-tabs-unselected :background bg-alt :foreground base6)
   ;; ;;;; css-mode <built-in> / scss-mode
   ;; (css-proprietary-property :foreground orange)
   ;; (css-property             :foreground green)
   ;; (css-selector             :foreground blue)
   ;; ;;;; doom-modeline
   ;; (doom-modeline-bar
   ;;  :background (if doom-vibrant-brighter-modeline modeline-bg highlight))
   ;; (doom-modeline-buffer-path
   ;;  :foreground (if doom-vibrant-brighter-modeline base8 blue) :bold bold)
   ;; ;;;; elscreen
   ;; (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")
   ;; ;;;; markdown-mode
   ;; (markdown-header-face :inherit 'bold :foreground red)
   ;; ;;;; solaire-mode
   ;; (solaire-mode-line-face
   ;;  :inherit 'mode-line
   ;;  :background modeline-bg-alt
   ;;  :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-alt)))
   ;; (solaire-mode-line-inactive-face
   ;;  :inherit 'mode-line-inactive
   ;;  :background modeline-bg-alt-inactive
   ;;  :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-alt-inactive)))
   ;; ;;;; whitespace <built-in>
   ;; (whitespace-empty :background base2)
   )

  ;;;; Base theme variable overrides
  ;; ()
  )
;;; doom-vibrant-theme.el ends here
