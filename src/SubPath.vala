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

using Gee;

namespace BluRay
{
	class SubPath : Object
	{
		public uint8 SubPathType { get; set; }

		public uint8 IsRepeatSubPath { get; set; }

		public ArrayList<SubPlayItem> SubPlayItem { get; set; }

		public SubPath.from_bit_input_stream (BitInputStream input_stream) throws ParseError
		{
			try
			{
				uint32 Length = input_stream.read_bits_as_uint32 (32);

				int64 Position = input_stream.tell (); // Needed to seek

				input_stream.skip_bits (8);

				SubPathType = input_stream.read_bits_as_uint8 (8);

				input_stream.skip_bits (15);

				IsRepeatSubPath = input_stream.read_bits_as_uint8 (1);

				uint8 NumberOfSubPlayItems = input_stream.read_bits_as_uint8 (8);

				SubPlayItem = new ArrayList<SubPlayItem> ();

				for (int i = 0; i < NumberOfSubPlayItems; i += 1)
				{
					// SubPlayItem
					SubPlayItem.add (new BluRay.SubPlayItem.from_bit_input_stream (input_stream));
				}

				input_stream.seek (Position + Length);
			}
			catch (ParseError e)
			{
				throw e;
			}
			catch (IOError e)
			{
				throw new ParseError.INPUT_ERROR ("Couldn't parse SubPath.");
			}
		}

//		public void write (BitOutputStream output_stream)
//		{
//		}
	}
}

