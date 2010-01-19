/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.tuwien.mm1.jmf.filters.noise;

/**
 *
 * @author camillo
 */
public interface Noise {
    /**
     *
     * @param a
     * @return
     */
    public float doRender(float a);
    /**
     *
     * @param i
     */
    public void setIntensitaet(int i);//in Prozent
}
