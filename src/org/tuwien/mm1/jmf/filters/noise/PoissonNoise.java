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
    private int maxPhotons;

    /**
     *
     * @return
     */
    public int getPhotons() {
        return photons;
    }

    /**
     *
     * @param photons
     */
    public void setPhotons(int photons) {
        this.photons = photons;
    }

    /**
     *
     * @param photons
     */
    public PoissonNoise(int photons){
        this.maxPhotons = photons;
    }

    /*@Override*/
    /**
     *
     * @param lambda
     * @return
     */
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

    /*@Override*/
    /**
     *
     * @param i
     */
    public void setIntensitaet(int i) {
        photons = 1;
    }

}
