package controladora;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;

import javafx.application.Application;
import javafx.event.Event;
import javafx.event.EventHandler;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.Pane;
import javafx.stage.Stage;
import vista.ViewConsultas;
import vista.ViewGestionarDatos;
import vista.ViewOpcionesFuncionario;
import vista.ViewPrincipal;

public class Controladora extends Application{
	
	private ViewGestionarDatos viewGestionarDatos;
	private ViewPrincipal viewPrincipal;
	private ViewOpcionesFuncionario viewOpcionesFuncionario;
	private ViewConsultas viewConsultas;
	
	@Override
	public void start(Stage primaryStage) throws Exception {
		FXMLLoader f = new FXMLLoader();
		FileInputStream file = new FileInputStream(new File("views/fxml/ViewPrincipal.fxml"));
		Pane pane = f.load(file);
		Scene scene = new Scene(pane, 285, 200);
//		scene.getStylesheets().add(new FileInputStream(new File("views/css/application.css")));
		primaryStage.setScene(scene);
		primaryStage.show();
		viewPrincipal = (ViewPrincipal)f.getController();
		registrarEventosViewPrincipal();
	}
	
	@SuppressWarnings("unchecked")
	private void registrarEventosViewPrincipal() {
		viewPrincipal.getButIngresar().addEventHandler(MouseEvent.MOUSE_CLICKED, controlarEventoPrincipal());
	}
	
	@SuppressWarnings("unchecked")
	private void registrarEventosViewOpcionesFuncionario() {
		viewOpcionesFuncionario.getButConsultas().addEventHandler(MouseEvent.MOUSE_CLICKED, controlarEventosOpcionesFuncionario());
		viewOpcionesFuncionario.getButAsignarSolic().addEventHandler(MouseEvent.MOUSE_CLICKED, controlarEventosOpcionesFuncionario());
		viewOpcionesFuncionario.getButAtenderSolic().addEventHandler(MouseEvent.MOUSE_CLICKED, controlarEventosOpcionesFuncionario());
		viewOpcionesFuncionario.getButGestorDatos().addEventHandler(MouseEvent.MOUSE_CLICKED, controlarEventosOpcionesFuncionario());
	}
	
	@SuppressWarnings("unchecked")
	private void registrarEventosConsultas() {
		viewConsultas.getButCsltaSolicXTipo().addEventHandler(MouseEvent.MOUSE_CLICKED, controlarEventosConsultas());
		viewConsultas.getButCsltaSolicXCliente().addEventHandler(MouseEvent.MOUSE_CLICKED, controlarEventosConsultas());
		viewConsultas.getButCsltaSolicXEstado().addEventHandler(MouseEvent.MOUSE_CLICKED, controlarEventosConsultas());
		viewConsultas.getButCsltaSolicXFunc().addEventHandler(MouseEvent.MOUSE_CLICKED, controlarEventosConsultas());
	}
	
	private EventHandler controlarEventosConsultas() {
		return new EventHandler() {
			@Override
			public void handle(Event evento) {
				String comando = ((Button)evento.getSource()).getText();
				switch(comando) {
				case "Consultar x funcionario":
					System.out.println("algo");
					break;
				case "Consultar x estado":
					System.out.println("algo");
					break;
				case "Consultar x tipo":
					System.out.println("algo");
					break;
				case "Consultar x cliente":
					System.out.println("algo");
					break;
				}
			}
			
		};
	}

	@SuppressWarnings("unchecked")
	private void registrarEventosGestionarDatos() {
		
	}
	
	@SuppressWarnings("rawtypes")
	private EventHandler controlarEventoPrincipal() {
		return new EventHandler() {
			@Override
			public void handle(Event evento) {
				String comando = ((Button)evento.getSource()).getText();
				switch(comando) {
				case "Ingresar":
					verificarUsuario();
					break;
				}
			}
			
		};
	}
	
	@SuppressWarnings("rawtypes")
	private EventHandler controlarEventosOpcionesFuncionario() {
		return new EventHandler() {
			@Override
			public void handle(Event evento) {
				String comando = ((Button)evento.getSource()).getText();
				Stage stage = new Stage();
				FXMLLoader f = new FXMLLoader();
				switch(comando) {
				case "Consultas":
					try {
						FileInputStream file = new FileInputStream(new File("views/fxml/ViewConsultas.fxml"));
						Pane pane = f.load(file);
						Scene scene = new Scene(pane, 586, 354);
						stage.setScene(scene);
						viewConsultas = (ViewConsultas)f.getController();
						registrarEventosConsultas();
						inicializarTipoSolicitudesEnConsultas();
						inicializarEstadosEnConsultas();
					}catch (Exception e) {
						e.printStackTrace();
					}
					stage.show();
					break;
				case "Atender solicitudes":
					
					break;
				case "Asignar solicitudes":
					
					break;
				case "Gestor de datos":
					try {
						FileInputStream file = new FileInputStream(new File("views/fxml/ViewGestionarDatos.fxml"));
						Parent pane = f.load(file);
						Scene scene = new Scene(pane, 328, 255);
						stage.setScene(scene);
						viewGestionarDatos = (ViewGestionarDatos)f.getController();
						registrarEventosGestionarDatos();
					}catch (Exception e) {
						e.printStackTrace();
					}
					stage.show();
					break;	
				}
			}
			
		};
	}
	
	private void inicializarEstadosEnConsultas() {
		// TODO setear el combo box del view consultas para mostrar los estados que existen.
		
	}

	private void inicializarTipoSolicitudesEnConsultas() {
		// TODO setear el combo box del view consultas para mostrar los tipos que existen.
		
	}
	
	@SuppressWarnings("rawtypes")
	private EventHandler controlarEventosGestionarClientes() {
		return new EventHandler() {
			@Override
			public void handle(Event evento) {
				String comando = ((Button)evento.getSource()).getText();
				switch(comando) {
				case "Agregar":
					
					break;
				case "Modificar":
					
					break;
				case "Borrar":
					
					break;
				}
			}
			
		};
	}
	@SuppressWarnings("rawtypes")
	private EventHandler controlarEventosGestionarTipoProductos() {
		return new EventHandler() {
			@Override
			public void handle(Event evento) {
				String comando = ((Button)evento.getSource()).getText();
				switch(comando) {
				case "Agregar":
					
					break;
				case "Modificar":
					
					break;
				case "Borrar":
					
					break;
				}
			}
			
		};
	}
	@SuppressWarnings("rawtypes")
	private EventHandler controlarEventosGestionarFuncionarios() {
		return new EventHandler() {
			@Override
			public void handle(Event evento) {
				String comando = ((Button)evento.getSource()).getText();
				switch(comando) {
				case "Agregar":
					
					break;
				case "Modificar":
					
					break;
				case "Borrar":
					
					break;
				}
			}
			
		};
	}
	@SuppressWarnings("rawtypes")
	private EventHandler controlarEventosGestionarTipoSolicitudes() {
		return new EventHandler() {
			@Override
			public void handle(Event evento) {
				String comando = ((Button)evento.getSource()).getText();
				switch(comando) {
				case "Agregar":
					
					break;
				case "Modificar":
					
					break;
				case "Borrar":
					
					break;
				}
			}
			
		};
	}
	
	public void verificarUsuario() {
		if(false/*usuario es cliente*/) {
			//TODO - completar
		}else if(true/*usuario es cliente*/) {
			Stage stage = new Stage();
			FXMLLoader f = new FXMLLoader();
			try {
				FileInputStream file = new FileInputStream(new File("views/fxml/ViewOpcionesFuncionario.fxml"));
				Pane pane = f.load(file);
				Scene scene = new Scene(pane,200,150);
				stage.setScene(scene);
				viewOpcionesFuncionario = (ViewOpcionesFuncionario) f.getController();
				registrarEventosViewOpcionesFuncionario();
			}catch (Exception e) {
				e.printStackTrace();
			}
			stage.show();
		}else {
			//TODO - usuario no existe
		}
	}

	public static void main(String[] args) {
		launch(args);
	}

}
