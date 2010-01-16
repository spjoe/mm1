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
    public float doRender(float a);
    public void setIntensität(int i);//in Prozent
}
