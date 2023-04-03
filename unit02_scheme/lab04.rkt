#lang racket
#|
Scheme Lab 4
Krish Arora and Matthew Specht Period 1
|#

(define/contract (DFA input Sigma S s0 delta F)
  (-> string? list? list? any/c list? list? boolean?)
  

  (define/contract (next-state current-state delta current-input)
    (-> any/c (listof (list/c any/c any/c any/c)) any/c any/c)
    (cond ((null? delta) #f)
          ((and (equal? (car (car delta)) current-state)
                (equal? (cadr (car delta)) current-input))
           (caddr (car delta)))
          (else (next-state current-state (cdr delta) current-input))))


  (define/contract (final-state? s F)
    (-> any/c list? boolean?)
    (cond ((null? F) #f)
          ((equal? s (car F)) #t)
          (else (final-state? s (cdr F)))))

  
  (cond
    ((eq? input "") (final-state? s0 F))
    ((eq? (next-state s0 delta (substring input 0 1)) #f) #f)
    ((> (string-length input) 1)
     (DFA (substring input 1) Sigma S (next-state s0 delta (substring input 0 1)) delta F))
    (else (DFA "" Sigma S (next-state s0 delta (substring input 0 1)) delta F))))


(define (NFA input Sigma Q q0 Delta F)
  (-> string? list? list? any/c list? list? boolean?)
  #t)


; #|
; --- Tests ---
(displayln "--- TESTS ---")

; Tests for DFA
(displayln "DFA")
(display "(DFA \"01\" '(\"1\" \"0\") '(q0 q1) 'q0 '((q0 \"0\" q0) (q0 \"1\" q1) (q1 \"0\" q1) (q1 \"1\" q1)) '(q1)) -> #t:   ")
(DFA "01" '("1" "0") '(q0 q1) 'q0 '((q0 "0" q0) (q0 "1" q1) (q1 "0" q1) (q1 "1" q1)) '(q1))
(display "(DFA \"0\" '(\"1\" \"0\") '(q0 q1) 'q0 '((q0 \"0\" q0) (q0 \"1\" q1) (q1 \"0\" q1) (q1 \"1\" q1)) '(q1)) -> #f:    ")
(DFA "0" '("1" "0") '(q0 q1) 'q0 '((q0 "0" q0) (q0 "1" q1) (q1 "0" q1) (q1 "1" q1)) '(q1))
(display "\n")
; |#
