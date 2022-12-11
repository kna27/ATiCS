#lang racket
; Scheme Lab 1
; Krish Arora Period 1

(define (y-intercept m b)
  b)

(define (x-intercept m b)
  (* (/ b m) -1))

(define (triangle-area m b)
  (abs (/ (* (x-intercept m b) (y-intercept m b)) 2)))



(define (modadd low high current addnum)
  (+ low (modulo (+ addnum (- current low)) (+ 1 (- high low)))))

(define (modsub low high current subnum)
  (modadd low high current (* subnum -1)))



(define (addtime time mins)
  (define time-in-mins (+ (* 60 (quotient time 100)) (modulo time 100)))
  (define total-mins (+ mins time-in-mins))
  (define final-hours (* 100 (modadd 1 12 (quotient total-mins 60) 0)))
  (define final-minutes (modulo total-mins 60))
  (+ final-hours final-minutes))



; #|
; --- Tests ---
(displayln "--- TESTS ---")

; Tests for y-intercept:
(displayln "y-intercept")
(display "(y-intercept 2 7) -> 7:      ")
(y-intercept 2 7)
(display "\n")

; Tests for x-intercept:
(displayln "x-intercept")
; Division by zero error
;(display "(x-intercept 0 3) -> DNE: ")
;(x-intercept 0 3)
(display "(x-intercept 5 0) -> 0:      ")
(x-intercept 5 0)
(display "(x-intercept 2 4) -> -2:     ")
(x-intercept 2 4)
(display "(x-intercept 1 -3) -> 3:     ")
(x-intercept 1 -3)
(display "(x-intercept -3 5) -> 1 2/3: ")
(x-intercept -3 5)
(display "\n")



; Tests for triangle-area:
(displayln "triangle-area")
(display "(triangle-area -1 -2) -> 2:  ")
(triangle-area -1 -2)
(display "(triangle-area 2 0) -> 0:    ")
(triangle-area 2 0)
(display "(triangle-area 4 4) -> 2:    ")
(triangle-area 4 4)
(display "\n")



; Tests for modadd:
(displayln "modadd")
(display "(modadd 4 7 5 1) -> 6:       ")
(modadd 4 7 5 1)
(display "(modadd 4 7 5 3) -> 4:       ")
(modadd 4 7 5 3)
(display "(modadd -2 1 0 -1) -> -1:    ")
(modadd -2 1 0 -1)
(display "(modadd -2 3 1 0) -> 1:      ")
(modadd -2 3 1 0)
(display "(modadd 1 1 1 2) -> 1:       ")
(modadd 1 1 1 2)
(display "(modadd -2 3 1 2) -> 3:      ")
(modadd -2 3 1 2)
(display "\n")

; Tests for modsub
(displayln "modsub")
(display "(modsub 4 7 5 0) -> 5:       ")
(modsub 4 7 5 0)
(display "(modsub 4 7 5 1) -> 4:       ")
(modsub 4 7 5 1)
(display "(modsub -2 1 0 6) -> -2:     ")
(modsub -2 1 0 6)
(display "(modsub -2 1 0 0) -> 0:      ")
(modsub -2 1 0 0)
(display "(modsub 1 1 1 2) -> 1:       ")
(modsub 1 1 1 2)
(display "(modsub 4 7 5 2) -> 7:       ")
(modsub 4 7 5 2)
(display "\n")



; Tests for addtime
(displayln "addtime")
(display "(addtime 1230 21) -> 1251:   ")
(addtime 1230 21)
(display "(addtime 530 0) -> 530:      ")
(addtime 530 0)
(display "(addtime 1230 91) -> 201:    ")
(addtime 1230 91)
(display "(addtime 545 135) -> 800:    ")
(addtime 545 135)
(display "(addtime 1250 9) -> 1259:    ")
(addtime 1250 9)
(display "(addtime 1250 10) -> 100:    ")
(addtime 1250 10)
(display "(addtime 130 525600) -> 130  ")
(addtime 130 525600)
(display "(addtime 245 -15) -> 230     ")
(addtime 245 -15)
(display "\n")
; |#
