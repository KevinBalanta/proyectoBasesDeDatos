CREATE OR REPLACE PACKAGE pkregistronivel2 AS
    PROCEDURE pregistrarestado (
        ivcodigo   IN VARCHAR2,
        ivnombre   IN VARCHAR2
    );

    PROCEDURE pregistrarfuncionario (
        ivcedula            IN VARCHAR2,
        ivnombre            IN VARCHAR2,
        ivdireccion         IN VARCHAR2,
        ivtelefono          IN VARCHAR2,
        ivfechanacimiento   IN DATE
    );

    PROCEDURE pregistraranomalia (
        ivnombre   IN VARCHAR2,
        ivid       IN VARCHAR2
    );

    PROCEDURE pregistrarcliente (
        ivcedula            IN VARCHAR2,
        ivnombre            IN VARCHAR2,
        ivfechanacimiento   IN VARCHAR2,
        ivdireccion         IN VARCHAR,
        ivtelefono          IN VARCHAR2
    );

    PROCEDURE pregistrarproducto (
        ividproducto     IN VARCHAR2,
        ivnombre         IN VARCHAR2,
        ivtipo_prod_id   IN VARCHAR2
    );

    PROCEDURE pregistrarsolicitud (
        tipoproducto     VARCHAR2,
        cedula           VARCHAR2,
        observacion      VARCHAR2,
        tiposolicitud    VARCHAR2,
        idproducto       VARCHAR2,
        ivcausa          VARCHAR2,
        nombreanomalia   VARCHAR2
    );

END pkregistronivel2;
/

CREATE OR REPLACE PACKAGE BODY pkregistronivel2 AS

    PROCEDURE pregistrarestado (
        ivcodigo   IN VARCHAR2,
        ivnombre   IN VARCHAR2
    ) IS
    BEGIN
        pkestadonivel1.pinsertar(ivcodigo,ivnombre);
    EXCEPTION
        WHEN OTHERS THEN
            raise_application_error(-20001,'Error al insertar en la tabla Funcionario' || sqlcode);
    END pregistrarestado;

    PROCEDURE pregistrarfuncionario (
        ivcedula            IN VARCHAR2,
        ivnombre            IN VARCHAR2,
        ivdireccion         IN VARCHAR2,
        ivtelefono          IN VARCHAR2,
        ivfechanacimiento   IN DATE
    ) IS
    BEGIN
        pkfuncionarionivel1.pinsertar(ivcedula,ivnombre,ivdireccion,ivtelefono,ivfechanacimiento);
    EXCEPTION
        WHEN OTHERS THEN
            raise_application_error(-20001,'Error al insertar en la tabla Funcionario' || sqlcode);
    END pregistrarfuncionario;

    PROCEDURE pregistrarproducto (
        ividproducto     IN VARCHAR2,
        ivnombre         IN VARCHAR2,
        ivtipo_prod_id   IN VARCHAR2
    ) IS
    BEGIN
        pkproductonivel1.pinsertar(ividproducto,ivnombre,ivtipo_prod_id);
    EXCEPTION
        WHEN OTHERS THEN
            raise_application_error(-20000,'Error al insertar en la tabla Producto' || sqlcode);
    END pregistrarproducto;

    PROCEDURE pregistraranomalia (
        ivnombre   IN VARCHAR2,
        ivid       IN VARCHAR2
    ) IS
    BEGIN
        pkanomalianivel1.pinsertar(ivnombre,ivid);
    EXCEPTION
        WHEN dup_val_on_index THEN
            raise_application_error(-20001,'El id esta duplicado.');
        WHEN OTHERS THEN
            raise_application_error(-20001,'Error'
                                            || sqlerrm
                                            || sqlcode);
    END pregistraranomalia;

    PROCEDURE pregistrarcliente (
        ivcedula            IN VARCHAR2,
        ivnombre            IN VARCHAR2,
        ivfechanacimiento   IN VARCHAR2,
        ivdireccion         IN VARCHAR,
        ivtelefono          IN VARCHAR2
    ) IS
    BEGIN
        pkclientenivel1.pinsertar(ivcedula,ivnombre,ivfechanacimiento,ivdireccion,ivtelefono);
    EXCEPTION
        WHEN dup_val_on_index THEN
            raise_application_error(-20001,'El id esta duplicado.');
        WHEN OTHERS THEN
            raise_application_error(-20001,'Unknown Error'
                                            || sqlerrm
                                            || sqlcode);
    END pregistrarcliente;

    PROCEDURE pregistrarsolicitud (
        tipoproducto     VARCHAR2,
        cedula           VARCHAR2,
        observacion      VARCHAR2,
        tiposolicitud    VARCHAR2,
        idproducto       VARCHAR2,
        ivcausa          VARCHAR2,
        nombreanomalia   VARCHAR2
    ) IS

        anomaliaid              VARCHAR2(50);
        fechaasignacion         DATE;
        fechaatencion           DATE;
        estadocodigo            VARCHAR2(50);
        funcionariocedula       VARCHAR2(50);
        comentariofuncionario   VARCHAR2(50);
        numerosolicitud         solicitud.n_solicitud%TYPE;
        causa                   VARCHAR2(50);
	numero			NUMBER;
    BEGIN
	numero := 0;
        numerosolicitud := TO_CHAR(pksolicitudn1.fsecuencia(numero));
        causa := ivcausa;
        fechaasignacion := SYSDATE;
        estadocodigo := '3';
        fechaatencion := NULL;
        funcionariocedula := NULL;
        anomaliaid := nombreanomalia;
        comentariofuncionario := NULL;
        CASE tiposolicitud
            WHEN '1' THEN
                causa := NULL;
                anomaliaid := NULL;
                pksolicitudn1.pinsertarsolicitud(numerosolicitud,observacion,fechaasignacion,fechaatencion,causa,comentariofuncionario
               ,cedula,estadocodigo,funcionariocedula,anomaliaid,tiposolicitud,idproducto);

            WHEN '2' THEN
                anomaliaid := NULL;
                pksolicitudn1.pinsertarsolicitud(numerosolicitud,observacion,fechaasignacion,fechaatencion,causa,comentariofuncionario
               ,cedula,estadocodigo,funcionariocedula,anomaliaid,tiposolicitud,idproducto);

            WHEN '3' THEN
                causa := NULL;
                pksolicitudn1.pinsertarsolicitud(numerosolicitud,observacion,fechaasignacion,fechaatencion,causa,comentariofuncionario
               ,cedula,estadocodigo,funcionariocedula,anomaliaid,tiposolicitud,idproducto);

            WHEN '5' THEN
                causa := NULL;
                anomaliaid := NULL;
                pksolicitudn1.pinsertarsolicitud(numerosolicitud,observacion,fechaasignacion,fechaatencion,causa,comentariofuncionario
               ,cedula,estadocodigo,funcionariocedula,anomaliaid,tiposolicitud,idproducto);

            WHEN '4' THEN
                pksolicitudn1.pinsertarsolicitud(numerosolicitud,observacion,fechaasignacion,fechaatencion,causa,comentariofuncionario
               ,cedula,estadocodigo,funcionariocedula,anomaliaid,tiposolicitud,idproducto);
        END CASE;

    EXCEPTION
        WHEN OTHERS THEN
            raise_application_error(-20201,' no esta registrado');
    END pregistrarsolicitud;

END pkregistronivel2;