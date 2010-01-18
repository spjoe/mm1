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
public class LorentzNoise implements Noise{
    Random rand = new Random();

    private float gamma;
    private float maxGamma;

    public float getGamma() {
        return gamma;
    }

    public void setGamma(float gamma) {
        this.gamma = gamma;
    }

    public LorentzNoise(float gamma){
        this.maxGamma = gamma;
    }

    /*@Override*/
    public float doRender(float mu) {
        double u = 0.0;
        while (u <= 0.0 || u >= 1.0)
            u = rand.nextDouble();
        return (float) (mu + gamma * Math.tan(Math.PI * (u - 0.5)));
    }

    /*@Override*/
    public void setIntensität(int i) {
        gamma = i/100.0f * maxGamma;
    }

}
