(defrule presion-arterial-alta
	(medida presion_arterial ?paciente ?pa ?pb)
	(test (> ?pa 14))
	(test (> ?pb 10))
	=>
	(assert (alta ?paciente presion-arterial))
)

(defrule riesgo-infarto
	(dolor ?paciente lado-izquierdo)
	(fumador ?paciente)
	(alta ?paciente presion-arterial)
	=>
	(assert (riesgo ?paciente infarto))
)

(defrule esclerotico
	(fumador ?paciente)
	(medida presion_arterial ?paciente ?pa ?pb)
	(test (> ?pa 14))
	=>
	(assert (riesgo ?paciente esclerosis))
)

(defrule alarma-nivel-Rojo
	(riesgo ?paciente esclerosis)
	(riesgo ?paciente infarto)
	=>
	(assert (alarma ?paciente Rojo))
)

(deffacts hechos-iniciales
	(fumador Antonio)
	(fumador Isabel)
	(fumador Andres)
	(medida presion_arterial Antonio 12 8)
	(medida presion_arterial Isabel 15 8)
	(medida presion_arterial Andres 16 11)
	(dolor Antonio lado-izquierdo)
	(dolor Andres lado-izquierdo)
	(dolor Isabel abdominal)
)
