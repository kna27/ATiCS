#lang racket
#|
Scheme Lab 2
Krish Arora Period 1
|#

(define (get-element list n)
  (cond
    ((zero? n) (car list))
    (else (get-element (cdr list) (- n 1)))
    )
  )



(define (append-element list y)
  (cond
    ((null? list) (cons y null))
    (else (cons (car list) (append-element (cdr list) y)))
    )
  )

(define (append-list first second)
  (cond
    ((null? first) second)
    (else (cons (car first) (append-list (cdr first) second)))
    )
  )



(define (backwards list)
  (cond
    ((null? list) list)
    (else (append-list (backwards (cdr list)) (cons (car list) null)))
    )
  )



(define (paren-balanced? str (stack null))
  (define (open-paren? char)
    (cond
      ((or (char=? char #\() (char=? char #\[) (char=? char #\{)) #t)
      (else #f)))
  
  (define (close-paren? char)
    (cond
      ((or (char=? char #\)) (char=? char #\]) (char=? char #\})) #t)
      (else #f)))
  
  (define (matches-stack? close)
    (define open (get-element stack (- (length stack) 1)))
    (cond
      ((and (equal? open #\() (equal? close #\))) #t)
      ((and (equal? open #\[) (equal? close #\])) #t)
      ((and (equal? open #\{) (equal? close #\})) #t)
      (else #f)
      )
    )
  
  (define (pop stack)
    (backwards (cdr (backwards stack))))

  
  (cond
    ((zero? (string-length str))
     (cond
       ((null? stack) #t)
       (else #f)
       )
     )
    (else
     (define first (string-ref str 0))
     (cond
       ((open-paren? first)
        (paren-balanced? (substring str 1) (append-element stack first)))
       ((close-paren? first)
        (cond
          ((null? stack) #f)
          ((matches-stack? first)
           (paren-balanced? (substring str 1) (pop stack)))
          (else #f)
          )
        )
       (else (paren-balanced? (substring str 1) stack))
       )
     )
    )
  )



; #|
; --- Tests ---
(displayln "--- TESTS ---")

; Tests for get-element
(displayln "get-element")
(display "(get-element '(0) 0) -> 0:                      ")
(get-element '(0) 0)
(display "(get-element '(1 2 3) 0) -> 1:                  ")
(get-element '(1 2 3) 0)
(display "(get-element '(1 2 3) 1) -> 2:                  ")
(get-element '(1 2 3) 1)
(display "(get-element '(1 2 3) 2) -> 3:                  ")
(get-element '(1 2 3) 2)
(display "\n")



; Tests for append-element
(displayln "append-element")
(display "(append-element '() 1) -> '(1):                 ")
(append-element '() 1)
(display "(append-element '(1) 2) -> '(1 2):              ")
(append-element '(1) 2)
(display "(append-element '(1 2 3) 4) -> '(1 2 3 4):      ")
(append-element '(1 2 3) 4)
(display "\n")

; Tests for append-list
(displayln "append-list")
(display "(append-list '() '()) -> '():                   ")
(append-list '() '())
(display "(append-list '() '(1)) -> '(1):                 ")
(append-list '() '(1))
(display "(append-list '(2) '()) -> '(2):                 ")
(append-list '(2) '())
(display "(append-list '(1 2) '(3 4)) -> '(1 2 3 4):      ")
(append-list '(1 2) '(3 4))
(display "\n")



; Tests for backwards
(displayln "backwards")
(display "(backwards '()) -> '():                         ")
(backwards '())
(display "(backwards '(1)) -> '(1):                       ")
(backwards '(1))
(display "(backwards '(1 2 3)) -> '(3 2 1):               ")
(backwards '(1 2 3))
(display "\n")



; Tests for paren-balanced?
(displayln "paren-balaned?")
(display "(paren-balanced? \"\") -> #t:                     ")
(paren-balanced? "")
(display "(paren-balanced? \"abc\") -> #t:                  ")
(paren-balanced? "abc")
(display "(paren-balanced? \"()\") -> #t:                   ")
(paren-balanced? "()")
(display "(paren-balanced? \"(]\") -> #f:                   ")
(paren-balanced? "(]")
(display "(paren-balanced? \"a(\") -> #f:                   ")
(paren-balanced? "a(")
(display "(paren-balanced? \"()[]{}(]\") -> #f:             ")
(paren-balanced? "()[]{}(]")
(display "(paren-balanced? \"()[]{}()\") -> #t:             ")
(paren-balanced? "()[]{}()")
(display "(paren-balanced? \"([{(([{(())}]))}])\") -> #t:   ")
(paren-balanced? "([{(([{(())}]))}])")
(display "(paren-balanced? \"a(b[c{}d]e)f\") -> #t:         ")
(paren-balanced? "a(b[c{}d]e)f")
(display "(paren-balanced? \"]\") -> #f:                    ")
(paren-balanced? "]")
(display "\n")
; |#
