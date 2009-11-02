/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.tuwien.mm1.jmf;

import javax.media.Buffer;
import javax.media.Effect;
import javax.media.Format;
import javax.media.ResourceUnavailableException;

/**
 *
 * @author camillo
 */
public class NoiseEffect implements Effect{

    @Override
    public Format[] getSupportedInputFormats() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public Format[] getSupportedOutputFormats(Format arg0) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public Format setInputFormat(Format arg0) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public Format setOutputFormat(Format arg0) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public int process(Buffer arg0, Buffer arg1) {
        arg0.copy(arg1);
        Object a = arg0.getData();
        System.out.println(a.getClass());
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public String getName() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void open() throws ResourceUnavailableException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void close() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void reset() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public Object[] getControls() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public Object getControl(String arg0) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

}
