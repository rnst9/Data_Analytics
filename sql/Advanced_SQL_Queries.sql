/*1. Nombre y apellidos de los profesores del departamento de Lenguajes.*/
SELECT profesores.nombre, apellido1, apellido2
FROM PROFESORES, departamentos
WHERE PROFESORES.DEPARTAMENTO = DEPARTAMENTOS.CODIGO AND DEPARTAMENTOS.NOMBRE='Lenguajes y Ciencias de la Computacion';

select p.nombre, p.apellido1, ifnull(p.apellido2, ' ')
from profesores P JOIN departamentos D on (P.departamento = D.codigo)
where upper(d.nombre) like '%LENGUAJES%';

/*2. Usando la función NVL extraiga un listado con el código y el nombre de las asignaturas
de las que está matriculado 'Nicolas Bersabe Alba'. Proporcione además el número de
créditos prácticos, pero caso de ser nulo, debe salir "No tiene" en el listado.*/

SELECT ALUMNOS.DNI, A.CODIGO, A.NOMBRE, IFNULL(A.PRACTICOS, 'NO TIENE') 'CREDITOS PRACTICOS'
FROM asignaturas A, ALUMNOS, MATRICULAR
WHERE ALUMNOS.DNI = matricular.ALUMNO
AND A.CODIGO = matricular.ASIGNATURA
AND UPPER(ALUMNOS.APELLIDO1) = 'BERSABE' AND UPPER(ALUMNOS.APELLIDO2) = 'ALBA';


/*3. Alumnos que tengan aprobada la asignatura 'Bases de Datos'*/
SELECT AL.NOMBRE, AL.APELLIDO1
FROM ALUMNOS AL, MATRICULAR MA, ASIGNATURAS ASI
WHERE CALIFICACION IS NOT NULL AND CALIFICACION != 'SP' AND MA.ALUMNO = AL.DNI AND
MA.ASIGNATURA = ASI.CODIGO AND UPPER(ASI.NOMBRE) = 'BASES DE DATOS';

/*4. Obtenga un listado en el que aparezcan el identificador de los profesores, su nombre y
apellidos, así como el código de las asignaturas que imparte y su nombre*/
SELECT distinct profesores.ID, profesores.NOMBRE, profesores.APELLIDO1, ifnull(profesores.APELLIDO2, ' ') 'APELLIDO2', asignaturas.CODIGO, asignaturas.NOMBRE
FROM PROFESORES, asignaturas, impartir
WHERE profesores.ID = impartir.profesor AND impartir.ASIGNATURA = asignaturas.CODIGO
ORDER BY 1;

/*5. Obtener el nombre de cada profesor junto con el de su director de tesis. En caso de no
tener director de tesis en el listado debe aparecer “No tiene”. */
SELECt CONCAT(P1.NOMBRE, ' ', P1. APELLIDO1, ' ', IFNULL(P1.APELLIDO2, ' ')) 'PROFESORES', ifnull(concat(p2.nombre, ' ', P2.APELLIDO1, ' ', IFNULL(P2.APELLIDO2, ' ')), 'NO TIENE') 'DIRECTOR TESIS'
FROM PROFESORES P1 LEFT OUTER JOIN profesores p2 ON p2.id = P1.DIRECTOR_TESIS
ORDER BY 2 DESC;

/*6. Nombre y edad de parejas de alumnos que tengan el mismo primer apellido. Téngase
en cuenta que los apellidos podrían estar en mayúscula o en minúscula*/
SELECT AL1.NOMBRE, AL1.APELLIDO1, TIMESTAMPDIFF(YEAR, AL1.FECHA_NACIMIENTO, SYSDATE()) 'EDAD 1', 
AL2.NOMBRE, AL2.APELLIDO1, TIMESTAMPDIFF(YEAR, AL2.FECHA_NACIMIENTO, SYSDATE()) 'EDAD 2'
FROM ALUMNOS AL1, ALUMNOS AL2
WHERE UPPER(AL1.APELLIDO1) = UPPER(AL2.APELLIDO1) AND AL1.DNI<AL2.DNI AND TIMESTAMPDIFF(YEAR, AL1.FECHA_NACIMIENTO, SYSDATE()) IS NOT NULL
AND TIMESTAMPDIFF(YEAR, AL2.FECHA_NACIMIENTO, SYSDATE()) IS NOT NULL ;

/*7. Combinaciones de apellidos que se pueden obtener con los primeros apellidos de
alumnos nacidos entre los años 1995 y 1996, ambos incluidos. Para obtener el año usar
la función YEAR. Se recomienda utilizar el operador BETWEEN … AND … para expresar el
rango de valores.*/

SELECT AL1.APELLIDO1, AL1.FECHA_NACIMIENTO, AL2.APELLIDO1, AL1.FECHA_NACIMIENTO
FROM ALUMNOS AL1, ALUMNOS AL2
WHERE YEAR(AL1.FECHA_NACIMIENTO) BETWEEN 1995 AND 1996 
AND YEAR(AL2.FECHA_NACIMIENTO) BETWEEN 1995 AND 1996
AND AL1.DNI < AL2.DNI
ORDER BY 1;

/*8. Nombre y apellidos de parejas de profesores cuya diferencia de antigüedad (en valor
absoluto) sea inferior a dos años y pertenezcan al mismo departamento. Muestre la
antigüedad de cada uno de ellos en años. Usar la función TIMESTAMPDIFF.*/

#La menor diferencia de antigüedad entre profesores de un mismo departamento es 6, por lo que no hay ninguna pareja que diste 2 o menos años

SELECT DISTINCT p1.NOMBRE, p1.APELLIDO1, p1.APELLIDO2, YEAR(p1.FECHA_NACIMIENTO) 'ANTIGÜEDAD',
p2.NOMBRE, p2.APELLIDO1, p2.APELLIDO2, YEAR(p2.FECHA_NACIMIENTO) 'ANTIGÜEDAD', 
ABS(TIMESTAMPDIFF(YEAR, p1.FECHA_NACIMIENTO,  p2.FECHA_NACIMIENTO )) 'diferencia'
FROM profesores P1, profesores P2
WHERE p1.DEPARTAMENTO = p2.DEPARTAMENTO 
AND ABS(TIMESTAMPDIFF(YEAR, p1.FECHA_NACIMIENTO,  p2.FECHA_NACIMIENTO )) <= 2
AND p1.ID < p2.ID;

/*10. Tríos de asignaturas pertenecientes a la misma materia. Debe presentarse el nombre de
las 3 asignaturas seguido del código de la materia a la que pertenecen.*/

select asig1.nombre 'asig 1', asig1.cod_materia, asig2.nombre 'asig 2', asig2.cod_materia, asig3.nombre 'asig 3', asig3.cod_materia, ma.nombre 'materia'
from asignaturas asig1, materias ma, asignaturas asig2, asignaturas asig3
where asig1.cod_materia= ma.codigo and asig2.cod_materia= ma.codigo and asig3.cod_materia= ma.codigo
and asig1.codigo < asig2.codigo
and asig1.codigo < asig3.codigo
and asig3.codigo < asig2.codigo;


/*11. Muestre el nombre, apellidos, nombre de la asignatura y las notas obtenidas por todos
los alumnos con más de 22 años. Utilice la función DECODE para mostrar la nota como
(Matricula de Honor, Sobresaliente, Notable, Aprobado, Suspenso o No Presentado).
Ordene por apellidos y nombre del alumno.*/

SELECT TIMESTAMPDIFF(YEAR, AL.FECHA_NACIMIENTO, SYSDATE()) 'edad', AL.NOMBRE, AL.APELLIDO1, IFNULL(AL.APELLIDO2, ' ') 'APELLIDO2', ASI.NOMBRE, CASE
WHEN MA.CALIFICACION = 'AP' THEN 'APROBADO'
WHEN MA.CALIFICACION = 'NT' THEN 'NOTABLE'
WHEN MA.CALIFICACION = 'SB' THEN 'SOBRESALIENTE'
WHEN MA.CALIFICACION = 'MH' THEN 'MATRICULA DE HONOR'  
ELSE 'NO PRESENTADO' END AS NOTA
FROM ALUMNOS AL, MATRICULAR MA, ASIGNATURAS ASI
WHERE AL.DNI = MA.ALUMNO AND MA.ASIGNATURA = ASI.CODIGO AND TIMESTAMPDIFF(YEAR, AL.FECHA_NACIMIENTO, SYSDATE()) > 22
ORDER BY 3, 4, 2;

/*12. Nombre y apellidos de todos los alumnos a los que les de clase Enrique Soler. Tenga en
cuenta que hay que utilizar los atributos ASINGNATURA, GRUPO y CURSO de las tablas
IMPARTIR y MATRICULAR. Cada alumno debe aparecer una sola vez. Ordénelos por
apellidos, nombre*/

SELECT CONCAT(ALUMNOS.NOMBRE, ' ', ALUMNOS.APELLIDO1, ' ') 'ALUMNO'
FROM (IMPARTIR NATURAL JOIN MATRICULAR) JOIN PROFESORES ON (IMPARTIR.PROFESOR = PROFESORES.ID) 
JOIN ALUMNOS ON MATRICULAR.ALUMNO = ALUMNOS.DNI
WHERE UPPER(PROFESORES.NOMBRE) = 'ENRIQUE' AND PROFESORES.APELLIDO1 = 'SOLER'
order by alumnos.apellido1, alumnos.nombre;

/*13. Nombre y apellidos de los alumnos matriculados en asignaturas impartidas por
profesores del departamento de 'Lenguajes y Ciencias de la Computación'. El listado
debe estar ordenado alfabéticamente.*/

select distinct alumnos.apellido1, alumnos.apellido2,  alumnos.nombre
from alumnos, matricular, asignaturas, departamentos
where alumnos.dni = matricular.alumno
and matricular.asignatura = asignaturas.codigo
and asignaturas.departamento = departamentos.CODIGO
and upper(departamentos.nombre) like 'LENGUAJES Y CIENCIAS DE LA COMPUTACION'
ORDER BY 1,2,3;

/*14. 4.Listado con el nombre de las asignaturas, nombre de la materia a la que pertenece y
nombre, apellidos y carga de créditos de los profesores que la imparten. El listado debe
estar ordenado por código de materia y por orden alfabético inverso del nombre de
asignatura. Usar la función concat para mostrar el nombre completo del profesor en una
sola columna. */

SELECT materias.codigo 'codigo materias', materias.nombre 'materias', 
asignaturas.nombre 'asignaturas', ifnull(concat(profesores.nombre, ' ', profesores.apellido1, ' ', PROFESORES.apellido2, ' '), 'desconocido') 'profesores',
  Sum(ifnull(impartir.CARGA_CREDITOS,0)) as total
FROM impartir, materias, asignaturas, profesores
where materias.codigo = asignaturas.COD_MATERIA
and impartir.ASIGNATURA = asignaturas.codigo
and impartir.profesor = profesores.id
group by concat(profesor, ' ', asignatura, ' ')
order by 1,3 desc;

/*15. Listado con el nombre de asignatura, nombre de departamento al que está asignada,
total de créditos y porcentaje de créditos prácticos, ordenado decrecientemente por el
porcentaje de créditos prácticos. Aquellas asignaturas cuyo número de créditos totales,
prácticos o teóricos no está especificado no deben salir en el listado.*/

select asignaturas.nombre 'asignaturas', departamentos.nombre 'departamento', asignaturas.creditos,
 truncate(asignaturas.practicos / asignaturas.creditos * 100,2) '% creditos practicos'
from asignaturas, departamentos
where asignaturas.departamento = departamentos.codigo
and creditos is not null and asignaturas.practicos / asignaturas.creditos * 100 is not null
order by 4 desc;

/*16. Utilice las operaciones de conjuntos para buscar alumnos que puedan ser familia de
algún profesor, es decir, su primer o segundo apellido es el mismo que el primer o
segundo apellido de un profesor, aunque no necesariamente en el mismo orden.
Muestre simplemente los apellidos comunes. */

(select CONCAT( ALUMNOS.NOMBRE, ' ', alumnos.apellido1, ' ', IFNULL(ALUMNOS.APELLIDO2, ' ')) 'ALUMNOS',
  CONCAT(PROFESORES.NOMBRE, ' ', PROFESORES.APELLIDO1, ' ', IFNULL(profesores.apellido1, ' ')) 'PROFESOR'
from alumnos, profesores
where alumnos.apellido1=profesores.apellido1)

UNION

(select CONCAT( ALUMNOS.NOMBRE, ' ', alumnos.apellido1, ' ', IFNULL(ALUMNOS.APELLIDO2, ' ')) 'ALUMNOS',
 CONCAT(PROFESORES.NOMBRE, ' ', PROFESORES.APELLIDO1, ' ', IFNULL(profesores.apellido1, ' ')) 'PROFESOR'
from alumnos, profesores
where alumnos.apellido2=profesores.apellido2);


/*17. Apellidos que contienen la letra elle ( 'll' ) tanto de alumnos como de profesores*/

SELECT DISTINCT Al1.APELLIDO1 'apellido CON LL'
FROM ALUMNOS al1 
WHERE al1.APELLIDO1 like '%ll%'

union

SELECT DISTINCT Al1.APELLIDO2
FROM ALUMNOS al1
WHERE al1.APELLIDO2 like '%ll%'

UNION

SELECT DISTINCT P.APELLIDO1
FROM PROFESORES P
WHERE P.APELLIDO1 like '%ll%'

UNION

SELECT DISTINCT P.APELLIDO2
FROM PROFESORES P
WHERE P.APELLIDO2 like '%ll%';


/*18. Busque una incongruencia en la base de datos, es decir, asignaturas en las que el
número de créditos teóricos + prácticos no sea igual al número de créditos totales.
Muestre también los profesores que imparten esas asignaturas. */

SELECT distinct ASI.NOMBRE, IFNULL(IM.PROFESOR, 'CODIGO DESCONOCIDO') 'id_PROFESOR', 
IFNULL(CONCAT(PROFESORES.NOMBRE, ' ', PROFESORES.APELLIDO1, ' ', IFNULL(profesores.apellido1, ' ')), 'DESCONOCIDO') 'PROFESOR'
FROM ASIGNATURAS ASI LEFT JOIN IMPARTIR IM ON IM.ASIGNATURA = ASI.CODIGO
LEFT JOIN PROFESORES ON IM.PROFESOR = PROFESORES.ID
WHERE (IFNULL(ASI.TEORICOS, 0) + IFNULL(ASI.PRACTICOS, 0)) != ASI.CREDITOS;

/*19. Muestre en orden alfabético los nombres completos de todos los profesores y a su lado
el de sus directores si es el caso (si no tenemos constancia de su director de tesis
dejaremos este espacio en blanco, pero el profesor debe aparecer en el listado).*/

SELECt CONCAT(P1.NOMBRE, ' ', P1. APELLIDO1, ' ', IFNULL(P1.APELLIDO2, ' ')) 'PROFESORES', ifnull(concat(p2.nombre, ' ', P2.APELLIDO1, ' ', IFNULL(P2.APELLIDO2, ' ')), ' ') 'DIRECTOR TESIS'
FROM PROFESORES P1 LEFT JOIN profesores p2 ON p2.id = P1.DIRECTOR_TESIS
ORDER BY P1.APELLIDO1;

/*20. Muestre el nombre y apellidos de cada profesor junto con los de su director de tesis y
el número de tramos de investigación del director. Recuerde que el director de tesis de
un profesor viene dado por el atributo DIRECTOR_TESIS y el número de tramos se
encuentra en la tabla INVESTIGADORES. Los nombres de cada profesor y su director
deben aparecer con el siguiente formato: 'El Director de Angel Mora Bonilla es Manuel
Enciso Garcia-Oliveros'*/

SELECt concat('El Director de ', p1.nombre, ' ', p1.apellido1, ' ', p2.apellido2,' es ', p2.nombre, ' ', p2.apellido1, ' ', p2.apellido2) 'prof-direc', ifnull(investigadores.tramos, 'no tiene') 'tramo investigacion'
FROM PROFESORES P1 left  JOIN profesores p2 ON p2.id = P1.DIRECTOR_TESIS left join investigadores on investigadores.id_profesor = p2.id
where p1.director_tesis is not null
ORDER BY P1.APELLIDO1;


/*21. Liste el nombre de todos los alumnos ordenados alfabéticamente. Si dicho alumno
tuviese otro alumno que se ha matriculado exactamente a la vez que él, muestre el
nombre de este segundo alumno a su lado.*/

SELECT al1.dni, al1.FECHA_PRIM_MATRICULA, al2.dni, al2.FECHA_PRIM_MATRICULA
FROM alumnos al1 right outer join alumnos al2 on al1.FECHA_PRIM_MATRICULA = al2.FECHA_PRIM_MATRICULA
where al1.dni < al2.dni;

/*22. Listado con el nombre de todas las asignaturas. En caso de que exista, para cada
asignatura se muestra el curso, grupo y nombre y primer apellido del profesor que la
imparte.*/

#LISTADO DE TODAS LAS ASIGNATURAS CON DATOS DE CODIGO, GRUPO, CURSO Y PROFESOR CONOCIDOS Y DESCONOCIDO
SELECT  a.nombre, ifnull(i.asignatura, 'desconocido') 'codigo', ifnull(i.grupo, 'desconocido') 'grupo', ifnull(i.curso, 'desconocido') 'curso', ifnull(concat(PROFESORES.nombre, ' ', profesores.apellido1, ' ', profesores.apellido2), 'desconocido') 'profesor'
FROM impartir i right join asignaturas a on i.asignatura = a.codigo
left join profesores on i.profesor = PROFESORES.ID;

#LISTADO DE TODAS LAS ASIGNATURAS CON DATOS DE CODIGO, GRUPO, CURSO Y PROFESOR CONOCIDOS
SELECT  a.nombre, ifnull(i.asignatura, 'desconocido') 'codigo', ifnull(i.grupo, 'desconocido') 'grupo', ifnull(i.curso, 'desconocido') 'curso', ifnull(concat(PROFESORES.nombre, ' ', profesores.apellido1, ' ', profesores.apellido2), 'desconocido') 'profesor'
FROM impartir i LEFT  join asignaturas a on i.asignatura = a.codigo
left join profesores on i.profesor = PROFESORES.ID;























