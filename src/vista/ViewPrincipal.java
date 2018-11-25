package vista;

import java.io.FileInputStream;
import java.io.FileNotFoundException;

import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;

public class ViewPrincipal {
	
	@FXML
    private ImageView imgBanner;

    @FXML
    private TextField txtCedula;

    @FXML
    private Button butIngresar;
	
    @FXML
	public void initialize() {
		try {		
			imgBanner.setImage(new Image(new FileInputStream("views/imagenes/banner.jpg")));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	}
    
    public Button getButIngresar() {
    	return butIngresar;
    }
	
}
