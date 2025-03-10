;;; doom-one-light-theme.el --- inspired by Atom One Light
(require 'doom-themes)

;;
(def-doom-theme romulus-light
  "A dark theme inspired by Atom One"

  ;; name        default   256       16
  (
   (bg         '("#fafafa" nil       nil            ))
   (bg-alt     '("#f0f0f0" nil       nil            ))
   (base0      '("#f0f0f0" "#f0f0f0" "white"        ))
   (base1      '("#e7e7e7" "#e7e7e7" "#000"  ))
   (base2      '("#dfdfdf" "#dfdfdf" "#000"  ))
   (base3      '("#c6c7c7" "#c6c7c7" "#000"  ))
   (base4      '("#9ca0a4" "#9ca0a4" "#000"  ))
   (base5      '("#383a42" "#424242" "#000"  ))
   (base6      '("#202328" "#2e2e2e" "#000"  ))
   (base7      '("#1c1f24" "#1e1e1e" "#000"  ))
   (base8      '("#1b2229" "black"   "black"        ))
   (fg         '("#383a42" "#424242" "black"        ))
   (fg-alt     '("#c6c7c7" "#c7c7c7" "#000"  ))

   (grey       base4)
   (red        '("#e45649" "#e45649" "red"          ))
   (orange     '("#da8548" "#dd8844" "#dd8844"    ))
   (green      '("#50a14f" "#50a14f" "green"        ))
   (teal       '("#4db5bd" "#44b9b1" "#44b9b1"  ))
   (yellow     '("#986801" "#986801" "yellow"       ))
   (blue       '("#4078f2" "#4078f2" "#4078f2"   ))
   (dark-blue  '("#a0bcf8" "#a0bcf8" "blue"         ))
   (magenta    '("#a626a4" "#a626a4" "magenta"      ))
   (violet     '("#b751b6" "#b751b6" "#c678dd"))
   (cyan       '("#0184bc" "#0184bc" "#46D9FF"   ))
   (dark-cyan  '("#005478" "#005478" "cyan"         ))

   (highlight      blue)
   (vertical-bar   (doom-darken base1 0.1))
   (selection      red)
   (builtin        (doom-darken magenta 0.3))
   (comments       "#0075c9")
   (doc-comments   (doom-lighten base5 0.25))
   ;; 'constants' is actually 'namespaces and classes' in C++
   (constants      (doom-darken orange 0.05))
   (functions      "#eaa000");
   (keywords       blue)
   (methods        cyan)
   (operators      blue)
   (type           red);yellow)
   (strings        "#007f0e")
   (variables      (doom-lighten magenta 0.1))
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
    (line-number :background "#ddd" :foreground "#000")
    (line-number-current-line :inverse-video t :bold bold)
   )
)

;;; doom-one-light-theme.el ends here
