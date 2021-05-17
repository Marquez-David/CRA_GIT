;Date: 25/05/2021
;Authors: David Márquez Mínguez y Robert Petrisor

(load "enteros.rkt")

(define longitud
  (lambda (l)
    ((Y (lambda (f)
          (lambda (x)
            (((vacia? x)
              (lambda (no_use)
                zero
                )
              (lambda (no_use)
                ((sumnat un) (f (cola x)))
                )
              )
             zero)  ; Pasa zero como argumento de no_use
            )
          ))
     l) ; Pasa l como el valor inicial de x.
    )
  )

(define comprobar-lista (lambda (l)
             (if (= (comprobar (longitud l)) 0)
                          '()
                  (cons (testenteros (cabeza l)) (comprobar-lista (cola l))))))

(define construir (lambda (x)
                    (lambda (y)
                      ((par false) ((par x) y)))))



(define vacia? (lambda (l)
                 (primero l)))


(define cola (lambda (l)
               (segundo (segundo l))))

(define cabeza (lambda (l)
                 (primero (segundo l))))

(define vacia (lambda (x) x))
(define lista-0 vacia)
(define lista-1 ((construir uno) vacia))


