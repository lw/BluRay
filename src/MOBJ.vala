/*
 * BluRay - a simple sample implementation of Blu-ray Disc specifications
 * Copyright (C) 2011  Luca Wehrstedt

 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.

 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

namespace BluRay
{
	class MOBJ : Object
	{
		public string TypeIndicator { get; set; }

		public string TypeIndicator2 { get; set; }

		public MovieObjects MovieObjects { get; set; }

		public ExtensionData ExtensionData { get; set; }

		public MOBJ.from_file_input_stream (FileInputStream input_stream) throws ParseError
		{
			try
			{
				this.from_bit_input_stream (new BitInputStream (input_stream));
			}
			catch (ParseError e)
			{
				throw e;
			}
		}

		public MOBJ.from_bit_input_stream (BitInputStream input_stream) throws ParseError
		{
			try
			{
				TypeIndicator = input_stream.read_string (4);
				TypeIndicator2 = input_stream.read_string (4);

				uint32 ExtensionDataStartAddress = input_stream.read_bits_as_uint32 (32);

				input_stream.skip_bits (224);

				// MovieObjects
				MovieObjects = new BluRay.MovieObjects.from_bit_input_stream (input_stream);

				if (ExtensionDataStartAddress != 0)
				{
					input_stream.seek (ExtensionDataStartAddress);

					// ExtensionData
					ExtensionData = new BluRay.ExtensionData.from_bit_input_stream (input_stream);
				}
			}
			catch (ParseError e)
			{
				throw e;
			}
			catch (IOError e)
			{
				throw new ParseError.INPUT_ERROR ("Couldn't parse MOBJ.");
			}
		}

//		public void write (BitOutputStream output_stream)
//		{
//		}
	}
}

