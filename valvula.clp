(deftemplate valvula
	(slot nombre)
	(slot T1(type INTEGER))
	(slot T2(type INTEGER))
	(slot presion(type INTEGER))
	(slot estado(allowed-values abierta cerrada)(default abierta))
)

(deftemplate alarma
	(slot nombre)
	(slot presion(type INTEGER))
	(slot limite_tempe(type INTEGER))
	(slot estado(allowed-values ON OFF)(default OFF))
)


(deffacts inicial
	(valvula (nombre Salida)(T1 10)(T2 55)(presion 5)(estado cerrada))	
	(valvula (nombre Pasillo)(T1 41)(T2 37)(estado abierta))
	(valvula (nombre Entrada)(T1 10)(T2 35)(presion	2)(estado cerrada))
)

(defrule R1
	?f1<-(valvula(nombre ?v)(T1 ?t1)(T2 ?t2)(presion ?P1)(estado abierta))
	?f2<-(alarma(nombre ?v)(presion	?p2)(limite_tempe ?lt)(estado ON))
	(test (>= ?P1 ?p2))
=>	
	(modify	?f1(presion 0))
)

(defrule R2 
	?f1<-(valvula (nombre ?v)(T1 ?t1)(T2 ?t2)(presion ?p)(estado cerrada))
	(test(<= ?p 5))
	(test(>	?t2 ?t1))
=>
	(modify	?f1 (estado abierta))
	(assert	(alarma	(nombre	?v)(presion ?p)																		(limite_tempe ?t1)(estado ON)))
)

(defrule R3
	?f1<-(valvula (nombre ?v1)(T1 ?t1)(T2 ?t12)(presion 0) (estado abierta))
	?f2<-(valvula (nombre ?v2)(T1 ?t1)(T2 ?t22)(presion 0) (estado abierta))
	?f3<-(alarma (nombre ?v1)(presion ?p3)(limite_tempe ?lt1) (estado ON))
	?f4<-(alarma (nombre ?v2)(presion ?p4)(limite_tempe ?lt2) (estado ON))
	(test(neq ?v1 ?v2))
=>	
	(modify	?f1 (presion(+ ?p3 ?p4))(estado	cerrada))
	(modify	?f2 (presion(+ ?p3 ?p4))(estado	cerrada))	
	(retract ?f3 ?f4)
)
