#lang racket
#|
Scheme Lab 4
Krish Arora and Matthew Specht Period 1
|#

(define max 50)

(define/contract (NFA-runner input Q q0 Delta F depth)
  (-> string? list? any/c list? list? number? boolean?)

  (define/contract (next-states s transition-input Delta)
    (-> any/c string? list? list?)
    (cond ((null? Delta) #f))
    (define delta (car Delta))
    (cond ((null? delta) #f))
    (cond
      ((and (equal? s (car delta)) (equal? transition-input (cadr delta)))
       (cond
         ((not (list? (caddr delta))) (cons (caddr delta) null))
         (else (caddr delta))))
      (else (next-states s transition-input (cdr Delta)))))
  
  (define/contract (final-state? s F)
    (-> any/c list? boolean?)
    (cond ((null? F) #f)
          ((equal? s (car F)) #t)
          (else (final-state? s (cdr F)))))

  
  (cond
    ((> depth max) #f)
    ((equal? (string-length input) 0) (final-state? q0 F))
    (else (ormap (λ (s) s)
                 (map (λ (next-state) (NFA-runner (substring input 1) Q next-state Delta F (+ 1 depth)))
                      (next-states q0 (substring input 0 1) Delta))))))


(define/contract (DFA input Sigma S s0 delta F)
  (-> string? list? list? any/c list? list? boolean?)
  (NFA-runner input S s0 delta F 0))
       
(define/contract (NFA input Sigma Q q0 Delta F)
  (-> string? list? list? any/c list? list? boolean?)
  (NFA-runner input Q q0 Delta F 0))


; #|
; --- Tests ---
(displayln "--- TESTS ---")

; Tests for DFA
(displayln "DFA")
(define/contract
  (DFA-test input)
  (-> string? boolean?)
  (DFA input '("1" "0") '(s0 s1) 's0 '((s0 "0" s0) (s0 "1" s1) (s1 "0" s1) (s1 "1" s1)) '(s1)))
(displayln "DFA for testing defined by the following tuples:
        \'(\"1\" \"0\")
        \'(s0 s1)
        \'s0
        \'((s0 \"0\" s0) (s0 \"1\" s1) (s1 \"0\" s1) (s1 \"1\" s1))
        '(s1)")
(displayln "Outputs for the following inputs:")
(display "(DFA-test \"1\") -> #t: ")
(displayln (DFA-test "1"))
(display "\n")

; Tests for NFA
(displayln "NFA")
(define/contract
  (NFA-test1 input)
  (-> string? boolean?)
  (NFA input '("0" "1") '(s0 s1 s2 s3 NA) 's0 
       '((s0 "0" (s0)) (s0 "1" (s0 s1)) (s1 "1" (s2)) (s1 "0" (NA)) (s2 "0" (NA)) (s2 "1" (s3)) 
                       (s3 "0" (s3)) (s3 "1" (s3)) (NA "0" (NA)) (NA "1" (NA))) 
       '(s3)))
(displayln "First NFA for testing defined by the following tuples:
        '(\"0\" \"1\")
        '(s0 s1 s2 s3 NA)
        's0 
        '((s0 \"0\" (s0)) (s0 \"1\" (s0 s1)) (s1 \"1\" (s2)) (s1 \"0\" (NA)) (s2 \"0\" (NA)) (s2 \"1\" (s3)) 
            (s3 \"0\" (s3)) (s3 \"1\" (s3)) (NA \"0\" (NA)) (NA \"1\" (NA))) 
        '(s3)")
(displayln "Outputs for the following inputs:")
; No input
(display "(NFA-test1 \"\") -> #f: ")
(displayln (NFA-test1 ""))
; Acceptable input
(display "(NFA-test1 \"111\") -> #t: ")
(displayln (NFA-test1 "111"))
; Acceptable input, but after surpassing max depth
(display "(NFA-test1 \"0110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110111\") -> #f: ")
(displayln (NFA-test1 "0110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110110111"))

(display "\n")
(define/contract
  (NFA-test2 input)
  (-> string? boolean?)
  (NFA input '() '(s0) 's0 '() '(s0)))
(displayln "Second NFA for testing defined by the following tuples:
       '()
       '(s0)
       's0
       '()
       '(s0)")
(displayln "Output for the following input:")
; no input
(display "(NFA-test2 \"\") -> #t: ")
(displayln (NFA-test2 ""))
; |#
