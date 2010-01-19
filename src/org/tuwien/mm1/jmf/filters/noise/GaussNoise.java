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
public class GaussNoise implements Noise {
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
    public GaussNoise(float sigma){
        this.maxSigma = sigma;
    }
    
    /**
     *
     * @param a
     * @return
     */
    public float doRender(float a) {
        double r = rand.nextGaussian(); //mean 0.0 sigma = 1.0 --> mean = a sigma =15n
        return (float) (a + (r*sigma));
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