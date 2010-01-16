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
    Random rand;

    public PoissonNoise(){
        rand = new Random();
    }

    @Override
    public float doRender(float lambda, Integer n) {
        double L, p;
            Integer k;

            if (n == 0)
                    return 0;

            L = Math.exp(-lambda);
            k = 0;
            p = 1;
            Random rand = new Random();
            do {
                    k++;
                    p = p * rand.nextDouble();
            } while (p >= L && k <= 255);
            return k - 1 + doRender(lambda, n - 1);
    }

}
