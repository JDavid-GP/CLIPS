(deffacts inicial
   (EstudianteUCA Pepe)
   (EstudianteUCA Paco)
   (Matematico Juan)
   (Matematico Jose)
   (Informatico Paco)
   (Asignatura IA Computacion)
   (Asignatura SI Computacion)
   (Facil IA)
)

(reset)

(defrule R1
	(Informatico ?x)
	(Asignatura ?y Computacion)
=>
	(assert (Matricula ?x ?y))
)

(run)

(defrule R2
	(Matematico ?x)
	(Asignatura ?y Computacion)
	(Facil ?y)
=>
	(assert (Matricula ?x ?y))
)

(run)

(defrule R3
	(EstudianteUCA ?x)
	(Matricula ?x ?y)
	(Asignatura ?y Computacion)
=>
	(assert (Aprueba ?x ?y))
)
