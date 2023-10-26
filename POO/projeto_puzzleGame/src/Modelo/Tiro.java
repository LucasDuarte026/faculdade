package Modelo;

import Auxiliar.Desenho;
import Controler.Tela;
import java.awt.Graphics;
import java.io.Serializable;

public class Tiro extends Personagem implements Serializable {

    private int decision;

    public Tiro(String sNomeImagePNG, int heroOrientation) {
        super(sNomeImagePNG);
        this.bProject = true;
        this.decision = heroOrientation;
        this.isTiro=true;
    }

    @Override
    public void autoDesenho() {
        super.autoDesenho();

        /*
    1 -> direita
    2 -> baixo
    3 -> esquerda
    4 -> cima
         */
        switch (decision) {
            case 1:
                if (!this.moveRight()) {
                    Desenho.acessoATelaDoJogo().removePersonagem(this);
                }
                break;
            case 2:
                if (!this.moveDown()) {
                    Desenho.acessoATelaDoJogo().removePersonagem(this);
                }
                break;
            case 3:
                if (!this.moveLeft()) {
                    Desenho.acessoATelaDoJogo().removePersonagem(this);
                }
                break;
            case 4:
                if (!this.moveUp()) {
                    Desenho.acessoATelaDoJogo().removePersonagem(this);
                }
                break;
            default:
                break;
        }

    }

    /*
    1 -> direita
    2 -> baixo
    3 -> esquerda
    4 -> cima
     */
}
