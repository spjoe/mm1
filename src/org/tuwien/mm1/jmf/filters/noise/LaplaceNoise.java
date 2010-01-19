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
public class LaplaceNoise implements Noise{
    Random rand = new Random();
    private float sigma;
    private float maxSigma;

    /**
     *
     * @return
     */
    public float getSigma() {
        return sigma;
    }

    /**
     *
     * @param sigma
     */
    public void setSigma(float sigma) {
        this.sigma = sigma;
    }

    /**
     *
     * @param sigma
     */
    public LaplaceNoise(float sigma){
        this.maxSigma = sigma;
    }

    /*@Override*/
    /**
     *
     * @param mu
     * @return
     */
    @SuppressWarnings("empty-statement")
    public float doRender(float mu) {
        double u, v;
        while ((u = rand.nextDouble()) == 0.0);
        v = rand.nextDouble();
        /* FIXME: rounding bias here! */
        return (float) (mu + sigma * Math.sqrt(-2 * Math.log(u)) * Math.cos(2 * Math.PI * v));
    }

    /*@Override*/
    /**
     *
     * @param i
     */
    public void setIntensitaet(int i) {
        sigma = i/100.0f * maxSigma;
    }

}
