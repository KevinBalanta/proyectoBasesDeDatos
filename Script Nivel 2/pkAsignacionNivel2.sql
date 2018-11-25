CREATE OR REPLACE PACKAGE pkasigancionnivel2 IS
    PROCEDURE pasignacionautomatica (
        ividsolicitud IN VARCHAR2
    );

    PROCEDURE pasignacionindividual (
        ividsolicitud   IN VARCHAR2,
        ivfuncioanrio   IN VARCHAR2
    );

END pkasigancionnivel2;
/
CREATE OR REPLACE PACKAGE BODY pkasigancionnivel2 IS

    PROCEDURE pasignacionautomatica (
        ividsolicitud IN VARCHAR2
    ) IS
        cedulafuncionario VARCHAR(50);
        cantidad      NUMBER;
        datosnumero   NUMBER;
        parametro NUMBER;
    BEGIN
        INSERT INTO tabla ( id )
            SELECT
                id
            FROM
                funcionario;

        SELECT
            COUNT(*)
        INTO datosnumero
        FROM
            tabla;

        WHILE datosnumero > 0 LOOP
            SELECT
                top(1) id
            INTO cedulafuncionario
            FROM
                tabla
            ORDER BY
                id;

            cantidad := pksolicitudn1.darsolicitudes(cedulafuncionario);
            parametro := pkparametrizacion.fconsultar(1).NUMEROSOLICITUDESFUNCIONARIO;
            IF cantidad < parametro THEN
                pksolicitudn1.pmodificarsolicitudasignacion(ividsolicitud,cedulafuncionario);
                datosnumero := 0;
            ELSE
                DELETE tabla
                WHERE
                    id = cedulafuncionario;

                SELECT
                    COUNT(*)
                INTO datosnumero
                FROM
                    tabla;

            END IF;

        END LOOP;

    END pasignacionautomatica;

    PROCEDURE pasignacionindividual (
        ividsolicitud   IN VARCHAR2,
        ivfuncioanrio   IN VARCHAR2
    ) IS
    BEGIN
        pksolicitudn1.pmodificarsolicitudasignacion(ividsolicitud,ivfuncioanrio);
    EXCEPTION
        WHEN no_data_found THEN
            raise_application_error(-20000,'Error' || sqlcode);
        WHEN OTHERS THEN
            raise_application_error(-20000,'Error' || sqlcode);
    END pasignacionindividual;

END pkasigancionnivel2;