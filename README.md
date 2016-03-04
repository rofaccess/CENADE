![Alt Text](https://github.com/rofaccess/CENADE/raw/master/files/cenade.jpg)
# SISTEMA DE GESTIÓN DE FICHAS Y PACIENTES

## Ingeniería del Software II - 2016

### Instrucciones para comenzar

1. Copia el archivo database.yml (que se encuentra en la carpeta files de tu repositorio local) a la carpeta /code/config de tu repositorio local.

2. Especifica tu nombre de usuario y contraseña para Postgresql en el archivo database.yml 

3. Ejecuta (para que instale las gemas) 
```
bundle install
```
4. Ejecuta (para que se cree la base de datos)
```
rake db:create
```
5. Ejecuta (para iniciar la aplicación)
```
rails server 
```
### Políticas de los commit

1. Existen dos branches permanentes:
 
 **master:** es el branch de producción que contiene el último release. No se agregarán cambios a él sino hasta el final del sprint.
 
 **development:** es el branch en donde todos los cambios serán agregados durante el sprint.

2. Por cada tarea se deberá crear un branch, cuyo nombre tendrá el siguiente formato: issue-numero-funcionalidad. Esto permitirá que cada desarrollador pueda trabajar en forma independiente sin afectar el trabajo de los demás, además se reducirá el riesgo de integrar bugs y errores a development.

3. En el caso de que exista una relación de dependencia entre tareas, se deberá hacer un branch para la tarea dependiente a partir del branch independiente.

4. Una vez que se haya terminado un feature y este haya pasado el testeo se podrá realizar el merge con development. Estos branches serán eliminados al final del sprint, para evitar la pérdida del historial en el caso de que se encuentren bugs que obliguen la reapertura de la tarea.

5. El último día del sprint se integrarán los cambios realizados en development al master (una vez que hayan pasado todos los tests) y se eliminarán los branches secundarios. 

6. Habrá una persona por proyecto encargada de hacer los builds así como también será la única persona autorizada a hacer push a los branches master y development. 

7. Los demás developers solo harán push a sus respectivos branches y cuando la tarea/issue/fix esté terminada en el branch harán un Pull request del branch correspondiente a development. Esto es básicamente solo un aviso para el que mantiene el master y development que hay cambios listos para hacer merge. 

8. El que mantiene descarga los cambios, hará un merge localmente y probará que todo esté bien, de ser así hará push a development. 

9. Los desarrolladores periódicamente deben hacer merge del branch development al branch en el que está trabajando para tener los últimos cambios integrados a development.

###Lecturas
* Git workflow: https://de.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow/
* Pushing and Pulling: https://de.atlassian.com/git/tutorials/syncing/
* Branches on Git: https://de.atlassian.com/git/tutorials/using-branches/git-branch/

###Con respecto a los commits
1. Los mensajes de los commits deben ser lo más específicos posibles, de forma a que los demás miembros del equipo (incluidos los product owners, el project leader y la tester) puedan saber qué cambios ha incluido el desarrollador.

2. Es recomendable realizar de 3 a 5 commits diarios. Esto permite dividir una tarea en funcionalidades más pequeñas a fin de facilitar el proceso de revisión y conservar el historial limpio y útil para análisis posteriores. También permite identificar más rápidamente en cuales commits se introdujeron bugs. 

**Ver:** 

	* Keeping Git Commits Small: https://crealytics.com/blog/2010/07/09/5-reasons-keeping-git-commits-small/

	* Separate Changes: https://www.kernel.org/pub/software/scm/git/docs/gitworkflows.html

3. Cada commit debe hacer referencia a la tarea asignada, es decir que debe figurar el número de issue, Ejemplo: issue#2.
