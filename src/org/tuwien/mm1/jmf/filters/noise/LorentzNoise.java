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

    public LorentzNoise(float gamma){
        this.gamma = gamma;
    }

    @Override
    public float doRender(float mu, Integer n) {
        double u = 0.0;
        while (u <= 0.0 || u >= 1.0)
            u = rand.nextDouble();
        return (float) (mu + gamma * Math.tan(Math.PI * (u - 0.5)));
    }

}
