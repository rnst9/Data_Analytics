LOAD DATA LOCAL INFILE 'C:/Users/usuario/Desktop/datos_docencia/alumnos.csv'

INTO TABLE docencia.alumnos FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'

IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/usuario/Desktop/datos_docencia/asignaturas.csv'

INTO TABLE docencia.asignaturas FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'

IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/usuario/Desktop/datos_docencia/correquisitos.csv'

INTO TABLE docencia.correquisitos FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'

IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/usuario/Desktop/datos_docencia/departamentos.csv'

INTO TABLE docencia.departamentos FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'

IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/usuario/Desktop/datos_docencia/impartir.csv'

INTO TABLE docencia.impartir FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'

IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/usuario/Desktop/datos_docencia/investigadores.csv'

INTO TABLE docencia.investigadores FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'

IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/usuario/Desktop/datos_docencia/materias.csv'

INTO TABLE docencia.materias FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'

IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/usuario/Desktop/datos_docencia/municipio.csv'

INTO TABLE docencia.municipio FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'

IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/usuario/Desktop/datos_docencia/prerrequisitos.csv'

INTO TABLE docencia.prerrequisitos FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'

IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/usuario/Desktop/datos_docencia/profesores.csv'

INTO TABLE docencia.profesores FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'

IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/usuario/Desktop/datos_docencia/provincia.csv'

INTO TABLE docencia.provincia FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'

IGNORE 1 LINES;