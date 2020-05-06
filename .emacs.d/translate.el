;; generated from ru-diktor and us-dvorak
(eval-when-compile
  (require 'cl))
(loop
  for from across "ёЁЪЬцЦьъяЯзЗвВкКдДчЧшШщЩуУиИеЕоОаАлЛнНтТсСрРйЙфФэЭхХыЫюЮбБмМпПгГжЖ"
  for to   across "`~!@'\",<.>fFgGcCrRlL/?=+aAoOeEuUiIdDhHtTnNsS-_;:qQjJkKxXbBmMwWvVzZ"
  do
  (eval `(define-key key-translation-map
	   (kbd ,(concat "C-" (string from)))
	   (kbd ,(concat "C-" (string to)))))
  (eval `(define-key key-translation-map
	   (kbd ,(concat "M-" (string from)))
	   (kbd ,(concat "M-" (string to)))))
  (eval `(define-key key-translation-map
	   (kbd ,(concat "C-M-" (string from)))
	   (kbd ,(concat "C-M-" (string to))))))
