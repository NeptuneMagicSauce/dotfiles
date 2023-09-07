;;; doom-one-theme.el --- inspired by Atom One Dark
(require 'doom-themes)

;;
(def-doom-theme romulus-dark-old
  "A dark theme inspired by Atom One Dark"

  ;; name        default   256       16
  (
   (bg         '("#2D2D2D" nil       nil            ))
   ;; (bg         '("gray5" nil       nil            ))
   ;; (bg         '("#282c34" nil       nil            ))
   (bg-alt     '("#21242b" nil       nil            ))
   (base0      '("#1B2229" "black"   "black"        ))
   (base1      '("#1c1f24" "#1e1e1e" "brightblack"  ))
   (base2      '("#202328" "#2e2e2e" "brightblack"  ))
   (base3      '("#23272e" "#262626" "brightblack"  ))
   (base4      '("#3f444a" "#3f3f3f" "brightblack"  ))
   (base5      '("#5B6268" "#525252" "brightblack"  ))
   (base6      '("#73797e" "#6b6b6b" "brightblack"  ))
   (base7      '("#9ca0a4" "#979797" "brightblack"  ))
   (base8      '("#DFDFDF" "#dfdfdf" "white"        ))
   (fg         '("#bbc2cf" "#bfbfbf" "brightwhite"  ))
   (fg-alt     '("#5B6268" "#2d2d2d" "white"        ))

   (grey       base4)
   (red        '("#ff6c6b" "#ff6655" "red"          ))
   (orange     '("#da8548" "#dd8844" "brightred"    ))
   (green      '("#98be65" "#99bb66" "green"        ))
   (teal       '("#4db5bd" "#44b9b1" "brightgreen"  ))
   (yellow     '("#ECBE7B" "#ECBE7B" "yellow"       ))
   (blue       '("#51afef" "#51afef" "brightblue"   ))
   (dark-blue  '("#2257A0" "#2257A0" "blue"         ))
   (magenta    '("#c678dd" "#c678dd" "magenta"      ))
   (violet     '("#a9a1e1" "#a9a1e1" "brightmagenta"))
   (cyan       '("#46D9FF" "#46D9FF" "brightcyan"   ))
   (dark-cyan  '("#5699AF" "#5699AF" "cyan"         ))

   ;; face categories -- required for all themes
   (highlight      blue)
   (vertical-bar   (doom-darken base1 0.1))
   (selection      red)
    ;; dark-blue)
   (builtin        magenta)
   (comments       "#9BD5FF")
                     ;; "#C1E5FF"))
                     ;; "#FFB5B5"))
                     ;; "#8CCFFF"))
                     ;; base5))
   (doc-comments (doom-lighten base5 0.25))
   ;; 'constants' is actually 'namespaces and classes' in C++
   (constants
    ;; red)
    ;; blue)
    ;; (doom-darken blue 1.0))
    ;; (doom-lighten orange 0.5))
    (doom-darken orange 0.05))
    ;; violet)
   (functions
    ;; "#FF4747")
    ;; "#FF7F7F")
    ;; orange)
    ;; magenta)
    ;; (doom-darken orange 0.05))
    "#FCE84F")
   (keywords       blue)
   (methods        cyan)
   (operators      blue)
   (type           "#FFAF87")
;;yellow)
   (strings
    "#98D765")
    ;; "#7DBC25")
    ;; green)
   (variables      "#FF5FFF")
;;(doom-lighten magenta 0.4))
   (numbers        orange)
   (region         `(,(doom-lighten (car bg-alt) 0.15) ,@(doom-lighten (cdr base0) 0.35)))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   )
   (
    ((line-number &override)
     :background "#222"
     :foreground "#999999")
   )
  )
