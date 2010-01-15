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

public class SimpleFilter implements Effect
{
	protected Format inputFormat = null;
	protected Format outputFormat = null;

	protected Format[] inputFormats = null;
	protected Format[] outputFormats = null;

	public SimpleFilter()
	{
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
                Dimension frameSize = vidFormat.getSize();
                //s nurSystem.out.println(rgbFormat.getBitsPerPixel());
                
                //int bits = rgbFormat.getBitsPerPixel();
                int row,col;
                for(row=0; row < frameSize.height; row++)
                    for(col=0; col < frameSize.width; col++){
                        data[row*frameSize.width * 3+ 3*col] = 0; //b
                        data[row*frameSize.width * 3+ 3*col+1] = 0; //g
                        data[row*frameSize.width * 3+ 3*col+2] +=2; //r
                    }

		output.setData(data);

		return BUFFER_PROCESSED_OK;
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
}