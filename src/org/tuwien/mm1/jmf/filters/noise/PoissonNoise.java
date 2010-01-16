/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.tuwien.mm1.jmf.filters.noise;

import java.util.Random;
/**
 *
 * @author camillo
 */
public class PoissonNoise implements Noise{
    Random rand = new Random();
    private int photons;

    public int getPhotons() {
        return photons;
    }

    public void setPhotons(int photons) {
        this.photons = photons;
    }

    public PoissonNoise(int photons){
        this.photons = photons;
    }

    public float doRender(float lambda) {
        return poissonHelp(lambda,photons);
        
    }
    private float poissonHelp(float lambda,int n){
        double L, p;
            Integer k;

            if (n == 0)
                    return 0;

            L = Math.exp(-lambda);
            k = 0;
            p = 1;
            do {
                    k++;
                    p = p * rand.nextDouble();
            } while (p >= L && k <= 255);
            return k - 1 + poissonHelp(lambda, n - 1);
    }

}
