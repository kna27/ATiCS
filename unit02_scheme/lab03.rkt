#lang racket
#|
Scheme Lab 3
Krish Arora Period 1
|#

(define/contract (func1 x)
  (-> number? number?)
  (+ (* x x) 2))

(define/contract func2
  (-> number? number?)
  (λ(x) (+ (* x x) 2)))

(define/contract dec
  (-> number? number?)
  (λ (x) (- x 1)))



(define/contract (evens lst)
  (-> list? list?)
  (map even? lst))

(define/contract (squares lst)
  (-> list? list?)
  (map (λ (num) (* num num)) lst))

(define/contract (bigs lst)
  (-> list? list?)
  (map (λ (pair) (max (car pair) (cadr pair))) lst))



(define/contract (eval-rpn lst (stack '()))
  (-> list? number?)
  (cond
    ((null? lst)(car stack))
    ((number? (car lst)) (eval-rpn (cdr lst) (cons (car lst) stack)))
    (else
     (define operation-applied (apply (car lst) (list (cadr stack) (car stack))))
     (define new-stack (cons operation-applied (cddr stack)))
     (eval-rpn (cdr lst) new-stack))))

(define/contract (in->postfix lst (operations null) (output null))
  (-> list? list?)
  (define/contract (operator? token)
    (-> any/c boolean?)
    (or (equal? token +) (equal? token -) (equal? token *) (equal? token /)))
  
  (define/contract (precedence operator)
    (-> any/c number?)
    (cond
      ((or (equal? operator "(") (equal? operator ")")) 0)
      ((or (equal? operator +) (equal? operator -)) 1)
      (else 2)))

  
  (cond
    ((empty? lst)
     (cond
       ((empty? operations) output)
       (else (in->postfix lst (cdr operations) (append output (cons (car operations) null))))
       )
     )
    (else
     (define token (car lst))
     (cond
       ((number? token) (in->postfix (cdr lst) operations (append output (cons token null))))
       ((operator? token)
        (cond
          ((and (not (empty? operations)) (>= (precedence (car operations)) (precedence token)))
           (in->postfix lst (cdr operations) (append output (cons (car operations) null))))
          (else (in->postfix (cdr lst) (cons token operations) output))
          )
        )
       ((equal? token "(") (in->postfix (cdr lst) (cons token operations) output))
       ((equal? token ")")
        (cond
          ((not (equal? (car operations) "("))
           (in->postfix lst (cdr operations)(append output (cons (car operations) null))))
          (else (in->postfix (cdr lst) (cdr operations) output))))))))

(define/contract (infix lst)
  (-> list? number?)
  (eval-rpn (in->postfix lst)))



; #|
; --- Tests ---
(displayln "--- TESTS ---")

; Tests for func1 and func2
(displayln "func1 and func2")
(display "(func1 0) -> 2:                                                                                ")
(func1 0)
(display "(func2 0) -> 2:                                                                                ")
(func2 0)
(display "(equal? (func1 0) (func2 0)) -> #t:                                                            ")
(equal? (func1 0) (func2 0))
(display "(func1 -2) -> 6:                                                                               ")
(func1 -2)
(display "(func2 -2) -> 6:                                                                               ")
(func2 -2)
(display "(equal? (func1 -2) (func2 -2)) -> #t:                                                          ")
(equal? (func1 -2) (func2 -2))
(display "(func1 5) -> 27:                                                                               ")
(func1 5)
(display "(func2 5) -> 27:                                                                               ")
(func2 5)
(display "(equal? (func1 5) (func2 5)) -> #t:                                                            ")
(equal? (func1 5) (func2 5))
(display "\n")

; Tests for dec
(displayln "dec")
(display "(dec 1) -> 0:                                                                                  ")
(dec 1)
(display "(dec -3) -> -4:                                                                                ")
(dec -3)
(display "\n")

; Tests for evens
(displayln "evens")
(display "(evens '()) -> '():                                                                            ")
(evens '())
(display "(evens '(0 1 10 -4 -3)) -> '(#t #f #t #t #f):                                                  ")
(evens '(0 1 10 -4 -3))
(display "\n")

; Tests for squares
(displayln "squares")
(display "(squares '()) -> '():                                                                          ")
(squares '())
(display "(squares '(0 2 -3 4.2)) -> '(0 4 9 17.64):                                                     ")
(squares '(0 2 -3 4.2))
(display "\n")

; Tests for bigs
(displayln "bigs")
(display "(bigs '((1 2) (3 4) (5 6)) -> '(2 4 6):                                                        ")
(bigs '((1 2) (3 4) (5 6)))
(display "\n")

; Tests for eval-rpn
(displayln "eval-rpn")
(display "(eval-rpn (list 0)) -> 0                                                                        ")
(eval-rpn (list 0))
(display "(eval-rpn (list 2 3 +)) -> 5                                                                    ")
(eval-rpn (list 2 3 +))
(display "(eval-rpn (list 3 4 5 + /)) -> 1/3:                                                             ")
(eval-rpn (list 3 4 5 + /))
(display "(eval-rpn (list 12 3 412 * 9 0 - / 2 / + 4 5 8 200 / * - +)) -> 84 7/15                         ")
(eval-rpn (list 12 3 412 * 9 0 - / 2 / + 4 5 8 200 / * - +))
(display "\n")

; Tests for in->postfix
(displayln "in->postfix")
(display "(in->postfix (list 2)) -> '(2):                                                                ")
(in->postfix (list 2))
(display "(in->postfix (list 2 / 5)) -> '(2 5 #<procedure:/>):                                           ")
(in->postfix (list 2 / 5))
(display "(in->postfix (list 1 * 2 + 3)) -> '(1 2 #<procedure:*> 3 #<procedure:+>):                      ")
(in->postfix (list 1 * 2 + 3))
(display "(in->postfix (list 1 + 2 * 3 / 4)) -> '(1 2 3 #<procedure:*> 4 #<procedure:/> #<procedure:+>): ")
(in->postfix (list 1 + 2 * 3 / 4))
(display"(in->postfix (list \"(\" 1 + 2 \")\" * 3 / \"(\"4 + 5\")\")) ->
                     '(1 2 #<procedure:+> 3 #<procedure:*> 4 5 #<procedure:+> #<procedure:/>): ")
(in->postfix (list "(" 1 + 2 ")" * 3 / "("4 + 5")"))
(display "\n")

; Tests for infix
(displayln "infix")
(display "(infix (list 2)) -> 2:                                                                          ")
(infix (list 2))
(display "(infix (list 2 * 3)) -> 6:                                                                      ")
(infix (list 2 * 3))
(display "(infix (list 2 * \"(\" 3 + 4 \")\")) -> 14:                                                         ")
(infix (list 2 * "(" 3 + 4 ")"))
(display "(infix (list 2 * \"(\" 3 + \"(\" 4 * 3 \")\" \")\")) -> 30:                                             ")
(infix (list 2 * "(" 3 + "(" 4 * 3 ")" ")"))
(display "\n")
; |#
