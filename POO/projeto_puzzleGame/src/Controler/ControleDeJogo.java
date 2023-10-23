package Controler;

import Modelo.Personagem;
import Modelo.Hero;
import Modelo.Box;
import auxiliar.Posicao;
import java.util.ArrayList;

public class ControleDeJogo {

    public void desenhaTudo(ArrayList<Personagem> e) {
        for (int i = 0; i < e.size(); i++) {
            e.get(i).autoDesenho();
        }
    }

    public void processaTudo(ArrayList<Personagem> umaFase) {
        Hero hero = (Hero) umaFase.get(0);
        Personagem pIesimoPersonagem;
        for (int i = 1; i < umaFase.size(); i++) {
            pIesimoPersonagem = umaFase.get(i);

            if (hero.getPosicao().igual(pIesimoPersonagem.getPosicao())) {
                System.out.println("entrou no asfdawfawfwf");
                if (pIesimoPersonagem.isbBox()) {
                    Posicao caixaPos = pIesimoPersonagem.getPosicao();
                    Posicao heroPos = hero.getPosicao();
                    System.out.println("entrou no teste");
                    if (heroPos.getColunaAnterior() - caixaPos.getColuna() < 0) {
                        /*caixa vai para cima*/
                        pIesimoPersonagem.setPosicao(caixaPos.getLinha(), caixaPos.getColuna() + 1);

                    } else if (heroPos.getColunaAnterior() - caixaPos.getColuna() > 0) {
                        /*Caixa vai para baixo*/
                        pIesimoPersonagem.setPosicao(caixaPos.getLinha(), caixaPos.getColuna() - 1);

                    } else if (heroPos.getLinhaAnterior() - caixaPos.getLinha() < 0) {
                        /*Caixa vai para baixo*/
                        pIesimoPersonagem.setPosicao(caixaPos.getLinha() + 1, caixaPos.getColuna());

                    } else if (heroPos.getLinhaAnterior() - caixaPos.getLinha() > 0) {
                        /*Caixa vai para baixo*/
                        pIesimoPersonagem.setPosicao(caixaPos.getLinha() - 1, caixaPos.getColuna());
                    }
                    break;
                }

                if (pIesimoPersonagem.isbTransponivel()) {
                    System.out.println("entrou dno transponivel");

                    if (pIesimoPersonagem.isbKey()) {
                        hero.addKey();
                        hero.printQuantKey();

                    }

                    /*TO-DO: verificar se o personagem eh mortal antes de retirar*/
                    umaFase.remove(pIesimoPersonagem);

                }
            }

        }

    }

    /*Retorna true se a posicao p é válida para Hero com relacao a todos os personagens no array*/
    public boolean ehPosicaoValida(ArrayList<Personagem> umaFase, Posicao p) {
        Personagem pIesimoPersonagem;
        for (int i = 1; i < umaFase.size(); i++) {
            pIesimoPersonagem = umaFase.get(i);
            if (!pIesimoPersonagem.isbTransponivel()) {
                if (pIesimoPersonagem.getPosicao().igual(p)) {
                    return false;
                }
            }
        }
        return true;
    }
}
