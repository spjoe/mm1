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

    public GaussNoise(float sigma){
        this.sigma = sigma;
    }
    
    public float doRender(float a, Integer n) {
        double r = rand.nextGaussian(); //mean 0.0 sigma = 1.0 --> mean = a sigma =15n
        return (float) (a + (r*sigma));
    }

}