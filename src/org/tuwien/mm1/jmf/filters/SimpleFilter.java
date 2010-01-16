/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.tuwien.mm1.jmf.filters;

/**
 *
 * @author camillo
 */
import java.awt.Dimension;

import javax.media.Buffer;
import javax.media.Effect;
import javax.media.Format;
import javax.media.ResourceUnavailableException;
import javax.media.format.RGBFormat;
import javax.media.format.VideoFormat;
import org.tuwien.mm1.jmf.filters.noise.*;

public class SimpleFilter implements Effect
{
	protected Format inputFormat = null;
	protected Format outputFormat = null;

	protected Format[] inputFormats = null;
	protected Format[] outputFormats = null;

        protected Noise noiseRender;

	public SimpleFilter()
	{
                init();
		noiseRender = new LorentzNoise(15);
	}
        public SimpleFilter(Noise n)
        {
            init();
            noiseRender = n;
        }
        private void init(){
            inputFormats = new Format[]{ new RGBFormat(null, Format.NOT_SPECIFIED, Format.byteArray, Format.NOT_SPECIFIED, 24, 3, 2, 1, 3, Format.NOT_SPECIFIED, Format.TRUE, Format.NOT_SPECIFIED) };
            outputFormats = new Format[]{ new RGBFormat(null, Format.NOT_SPECIFIED, Format.byteArray, Format.NOT_SPECIFIED, 24, 3, 2, 1, 3, Format.NOT_SPECIFIED, Format.TRUE, Format.NOT_SPECIFIED) };
        }

	/****** Codec ******/
	public Format[] getSupportedInputFormats()
	{
		return inputFormats;
	}

	public Format[] getSupportedOutputFormats(Format input)
	{
		if(input != null)
		{
			if(matches(input, inputFormats) != null)
				return new Format[]{ outputFormats[0].intersects(input) };
			else
				return new Format[0];
		}

		return outputFormats;
	}

	public int process(Buffer input, Buffer output)
	{
		// Swap tra input & output
		output.copy(input);
                byte[] data = (byte[])input.getData();
                //System.out.println(inputFormat.getEncoding());

                VideoFormat vidFormat = (VideoFormat)inputFormat;
                RGBFormat rgbFormat = (RGBFormat)vidFormat;
                //System.out.println(vidFormat);
                //Dimension frameSize = vidFormat.getSize();
                //s nurSystem.out.println(rgbFormat.getBitsPerPixel());
                
                //int bits = rgbFormat.getBitsPerPixel();

                for(int i = 0; i < data.length; i++){
                    
                    float c = noiseRender.doRender( ((int) data[i] & 0xFF));
                    data[i] = clip(c,0,255);
                }
                
		output.setData(data);

		return BUFFER_PROCESSED_OK;
	}
        private byte clip(float a, Integer down, Integer upp){
            if (a < down) return down.byteValue();
            if (a > upp) return upp.byteValue();

            return (byte)a;
        }
	public Format setInputFormat(Format input)
	{
		inputFormat = input;

		return input;
	}

	public Format setOutputFormat(Format output)
	{
		if(output != null || matches(output, outputFormats) != null)
		{
			RGBFormat inRGB = (RGBFormat) output;

			Dimension size = inRGB.getSize();
			int maxDataLength = inRGB.getMaxDataLength();
			int lineStride = inRGB.getLineStride();
			int flipped = inRGB.getFlipped();

			if(size == null)
				return null;

			if(maxDataLength < size.width*size.height*3)
				maxDataLength = size.width*size.height*3;

			if(lineStride < size.width*3)
				lineStride = size.width*3;

			if(flipped != Format.FALSE)
				flipped = Format.FALSE;

			outputFormat = outputFormats[0].intersects(new RGBFormat(size, maxDataLength, inRGB.getDataType(), inRGB.getFrameRate(), inRGB.getBitsPerPixel(), inRGB.getRedMask(), inRGB.getGreenMask(), inRGB.getBlueMask(), inRGB.getPixelStride(), lineStride, flipped, inRGB.getEndian()));

			return outputFormat;
		}

		return null;
	}
	/****** Codec ******/

	/****** PlugIn ******/
	public void close()
	{

	}

	public String getName()
	{
		return "Simple-Filter";
	}

	public void open() throws ResourceUnavailableException
	{

	}

	public void reset()
	{

	}
	/****** PlugIn ******/

	/****** Controls ******/
	public Object getControl(String controlType)
	{
		return null;
	}

	public Object[] getControls()
	{
		return null;
	}
	/****** Controls ******/

	/****** Utility ******/
	private Format matches(Format in, Format[] out)
	{
		if(in != null && out != null)
		{
			for(int i=0, cnt=out.length; i<cnt; i++)
			{
				if(in.matches(out[i]))
					return out[i];
			}
		}

		return null;
	}
	/****** Utility ******/
        public void setNoiseRender(Noise n){
            noiseRender = n;
        }
        public Noise getNoiseRender(){
            return noiseRender;
        }
}