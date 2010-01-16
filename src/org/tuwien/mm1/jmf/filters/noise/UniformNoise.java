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

    public float getWidth() {
        return width;
    }

    public void setWidth(float width) {
        this.width = width;
    }
    public UniformNoise(float width){
        this.width = width;
    }

    @Override
    public float doRender(float mu) {
        double u;
        u = rand.nextDouble();
        return (float) (mu + width * (u - 0.5));
    }

}