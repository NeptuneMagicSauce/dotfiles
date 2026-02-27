;;; romulus-light-theme.el --- a more vibrant variant of doom-one -*- lexical-binding: t; no-byte-compile: t; -*-

;; option no-byte-compile t on first line is important
;; otherwise we fail the compile with Error: Bytecode overflow

(require 'doom-themes)

(defgroup doom-vibrant-theme nil
  "Options for the `doom-vibrant' theme."
  :group 'doom-themes)

(def-doom-theme romulus-light
  "My theme inspired by BluLoco light"

  ;; name        default   256       16
  (
   (bg           '("#f0f0f0" "#f0f0f0"   "white"        ))
   (fg           '("#383a42" "#424242" "black"        ))

   (bg-alt       '("#e7e7e7" "white"   "white"        ))
   (fg-alt       '("#c6c7c7" "#c7c7c7" "#000"  ))


   (base0        '("#f1f1f1" "#f0f0f0" "white"        ))
   (base1        '("#e7e7e7" "#e7e7e7" "#000"  ))
   (base2        '("#dfdfdf" "#dfdfdf" "#000"  ))
   (base3        '("#c6c7c7" "#c6c7c7" "#000"  ))
   (base4        '("#9ca0a4" "#9ca0a4" "#000"  ))
   (base5        '("#383a42" "#424242" "#000"  ))
   (base6        '("#202328" "#2e2e2e" "#000"  ))
   (base7        '("#1c1f24" "#1e1e1e" "#000"  ))
   (base8        '("#1b2229" "black"   "black"        ))

   (grey         '("#a0a1a7" "#a0a1a7" "#000"  ))
   ;; (red          '("#F00" "#F00" "#F00"))
   ;; (red          '("#d52753"  "#d7005f" "red"          ))
   (red          '("#ff665c" "#ff6655" "red"          ))
   (orange       '("#df631c" "#d75f00" "#dd8844"    ))
   (brown        '("#a05a48" "#af5f5f" "brown"        ))
   (green        '("#23974a" "#00875f" "green"        ))
   (dark-green   '("#4e855d" "#2e8746" "#2e8746"))
   (teal         '("#40B8C5" "#5fafd7" "#44b9b1"  ))
   (yellow       '("#c5a332" "#d7af5f" "yellow"       ))
   (blue         '("#0098dd" "#0087d7" "#0087d7"   ))
   (dark-blue    '("#275fe4" "#005fd7" "blue"         ))
   (magenta      '("#ce33c0" "#d75faf" "magenta"      ))
   (violet       '("#823ff1" "#875fff" "#c678dd"))
   (dark-violet  '("#7a82da" "#8787d7" "#c678dd"))
   (cyan         '("#33c0ce" "#5fafd7" "#46D9FF"   ))
   (dark-cyan    '("#217b84" "#008080" "#46D9FF"   ))


   (highlight      red);"#000");"#010101");blue)
   (region         "#FFF")
    ;; `(,(doom-darken (car bg-alt) 0.075) ,@(doom-darken (cdr base0) 0.075)))
   (vertical-bar   (doom-darken base1 0.1))
   (selection      dark-blue)
   (builtin        green)
   ;; (comments       grey)
   ;; (comments       green)
   (comments       dark-blue)
   (doc-comments   dark-violet);violet);magenta)
   (constants      violet)
   ;; (functions      green)
   (functions      dark-blue)
   ;; (functions "#007F0E")
   (keywords       blue)
   (methods        green)
   (operators      dark-violet)
   ;; (type           (doom-darken green 0.1));red)
   (type dark-green);dark-violet); magenta)
   ;; (strings        yellow)
   (strings        green)
   ;; (strings0         "#0094FF")
   ;; (strings red)
   ;; (variables      teal) ; bad
   ;; (variables      orange) ; ok
   ;; (variables      brown) ; ok
   ;; (variables      green) ; ok but already used
   ;; (variables      yellow) ; bad
   ;; (variables      blue) ; ok but already used
   ;; (variables      dark-blue) ; good
   (variables      magenta) ; good
   ;; (variables      violet) ; best
   ;; (variables      dark-violet) ; ok
   ;; (variables      cyan) ; bad
   ;; (variables      dark-cyan) ; bad
   (numbers        magenta)
   (error          red)
   (warning        orange)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)




   )
   (
    (line-number :background "#ddd" :foreground "#000")
    (line-number-current-line :inverse-video t :bold bold)
    ;; (line-number-current-line :background "#444" :foreground "#fff" :bold bold)

    ;; lsp-ui
    ;; fix-it suggestions in sideline:
    (lsp-ui-sideline-global :box nil :inverse-video t)

    ;; Markdown
    (markdown-header-delimiter-face :foreground "#A30000" :bold bold)  ;; # symbols
    (markdown-header-face-1 :inherit 'markdown-header-delimiter-face)
    (markdown-header-face-2 :foreground "#A30028" :bold bold)
    (markdown-header-face-3 :foreground "#A30050" :bold bold)
    (markdown-header-face-4 :foreground "#A30078" :bold bold)
    (markdown-header-face-5 :foreground "#A300A0" :bold bold)
    (markdown-header-face-6 :foreground "#A300C8" :bold bold)
    )
)

;;; doom-bluloco-light-theme.el ends here
