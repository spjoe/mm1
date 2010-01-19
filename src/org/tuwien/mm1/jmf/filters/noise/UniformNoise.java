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
public class UniformNoise implements Noise{
    Random rand = new Random();
    private float width;
    private float maxWidth;

    /**
     *
     * @return
     */
    public float getWidth() {
        return width;
    }

    /**
     *
     * @param maxWidth
     */
    public void setWidth(float maxWidth) {
        this.width = maxWidth;
    }
    /**
     *
     * @param width
     */
    public UniformNoise(float width){
        this.maxWidth = width;
    }

    /*@Override*/
    /**
     *
     * @param mu
     * @return
     */
    public float doRender(float mu) {
        double u;
        u = rand.nextDouble();
        return (float) (mu + width * (u - 0.5));
    }

    /*@Override*/
    /**
     *
     * @param i
     */
    public void setIntensitaet(int i) {
        width = i/100.0f * maxWidth;
    }

}
